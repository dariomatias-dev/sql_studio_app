import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_editor/data/providers/sql_editor_data_providers.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  late _MockSqlCommandsRepository repository;
  late ProviderContainer container;

  const toastChannel = MethodChannel('PonnamKarthik/fluttertoast');

  setUp(() async {
    final prefs = await fakeSharedPreferencesService();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, (_) async => true);

    repository = _MockSqlCommandsRepository();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        sqlCommandsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, null);
  });

  Future<void> pumpEditor(WidgetTester tester) {
    return tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: SqlEditorWidget()),
        ),
      ),
    );
  }

  testWidgets('renders the panel title and the default suggestion bars', (
    tester,
  ) async {
    await pumpEditor(tester);

    expect(find.text('Editor'), findsOneWidget);
    expect(find.byType(SqlBasicSuggestionsBarWidget), findsOneWidget);
    expect(find.byType(SqlCharacterBarWidget), findsOneWidget);
    expect(find.byType(SqlAdvancedSuggestionsBarWidget), findsNothing);
  });

  testWidgets('typing into the field updates the editor state', (
    tester,
  ) async {
    await pumpEditor(tester);

    await tester.enterText(find.byType(TextField), 'SELECT 1');
    await tester.pump();

    expect(
      container.read(sqlEditorViewModelProvider.notifier).controller.text,
      'SELECT 1',
    );

    await tester.pump(const Duration(milliseconds: 600));
  });

  testWidgets('running the query executes it against the active database', (
    tester,
  ) async {
    await pumpEditor(tester);

    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'my_db';
    container.read(sqlEditorViewModelProvider.notifier).controller.text =
        'SELECT 1';

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer((_) async => const SuccessResult(null));

    await tester.tap(find.byTooltip('Run Query'));
    await tester.pumpAndSettle();

    verify(
      () => repository.execute(sql: 'SELECT 1', databaseName: 'my_db'),
    ).called(1);
  });

  testWidgets('clearing the editor empties its text', (tester) async {
    await pumpEditor(tester);

    container.read(sqlEditorViewModelProvider.notifier).controller.text =
        'SELECT 1';

    await tester.tap(find.byTooltip('Clear Editor'));
    await tester.pump();

    expect(
      container.read(sqlEditorViewModelProvider.notifier).controller.text,
      '',
    );
  });

  testWidgets('loading the last query restores it into the editor', (
    tester,
  ) async {
    await pumpEditor(tester);

    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'my_db';

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer((_) async => const SuccessResult(null));

    await container
        .read(sqlCommandsViewModelProvider.notifier)
        .runQuery('SELECT * FROM users');

    await tester.tap(find.byTooltip('Load Last SQL'));
    await tester.pump();

    expect(
      container.read(sqlEditorViewModelProvider.notifier).controller.text,
      'SELECT * FROM users',
    );

    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('hides the options menu when no database is selected', (
    tester,
  ) async {
    await pumpEditor(tester);

    expect(find.byType(PopupMenuButtonWidget), findsNothing);
  });

  testWidgets('shows the options menu once a database is selected', (
    tester,
  ) async {
    await pumpEditor(tester);

    container.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
        'my_db';
    await tester.pump();

    expect(find.byType(PopupMenuButtonWidget), findsOneWidget);
  });
}

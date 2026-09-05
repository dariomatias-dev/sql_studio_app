import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/database_delete_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/create_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_database_by_name_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/get_databases_usecase.dart';
import 'package:sql_studio/src/features/database/domain/usecases/toggle_database_favorite_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';

import '../../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

void main() {
  late _MockDatabaseRepository repository;
  late _MockSqlExecutionService sqlExecutionService;
  late ProviderContainer container;

  final db = DatabaseModel(label: 'Todo List', name: 'todo_list');

  Widget wrap(Widget child) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          drawer: Drawer(child: child),
          body: const SizedBox(),
        ),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(db);
  });

  setUp(() async {
    final prefs = await fakeSharedPreferencesService();

    repository = _MockDatabaseRepository();
    sqlExecutionService = _MockSqlExecutionService();

    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        getDatabasesUseCaseProvider.overrideWithValue(
          GetDatabasesUseCase(repository),
        ),
        createDatabaseUseCaseProvider.overrideWithValue(
          CreateDatabaseUseCase(repository),
        ),
        getDatabaseByNameUseCaseProvider.overrideWithValue(
          GetDatabaseByNameUseCase(repository),
        ),
        deleteDatabaseUseCaseProvider.overrideWithValue(
          DeleteDatabaseUseCase(repository, sqlExecutionService),
        ),
        toggleDatabaseFavoriteUseCaseProvider.overrideWithValue(
          ToggleDatabaseFavoriteUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  testWidgets('renders the database label and name', (tester) async {
    await tester.pumpWidget(wrap(RootDrawerDatabaseCardWidget(database: db)));

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Todo List'), findsOneWidget);
    expect(find.text('todo_list'), findsOneWidget);
  });

  testWidgets(
    'tapping the card selects it as the active database and closes the '
    'drawer',
    (tester) async {
      await tester.pumpWidget(
        wrap(RootDrawerDatabaseCardWidget(database: db)),
      );

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold))
        ..openDrawer();
      await tester.pumpAndSettle();
      expect(scaffoldState.isDrawerOpen, isTrue);

      await tester.tap(find.byType(RootDrawerDatabaseCardWidget));
      await tester.pumpAndSettle();

      expect(
        container.read(sqlCommandsViewModelProvider).activeDatabase,
        'Todo List',
      );
      expect(container.read(navigationViewModelProvider), 0);
      expect(scaffoldState.isDrawerOpen, isFalse);
    },
  );

  testWidgets('toggling favorite calls the use case and flips the icon', (
    tester,
  ) async {
    when(
      () => repository.toggleFavorite(any()),
    ).thenAnswer((_) async => SuccessResult(db.copyWith(isFavorite: true)));

    await tester.pumpWidget(wrap(RootDrawerDatabaseCardWidget(database: db)));

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);

    await tester.tap(find.text('Favorite'));
    await tester.pumpAndSettle();

    verify(() => repository.toggleFavorite(any())).called(1);

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    expect(find.text('Unfavorite'), findsOneWidget);
  });

  testWidgets('reverts the favorite icon when the toggle fails', (
    tester,
  ) async {
    when(() => repository.toggleFavorite(any())).thenAnswer(
      (_) async => const FailureResult(
        DatabaseFailure(AppLocalizationsKey.unknownError),
      ),
    );

    await tester.pumpWidget(wrap(RootDrawerDatabaseCardWidget(database: db)));

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Favorite'));
    await tester.pumpAndSettle();

    expect(find.text('OK'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);
  });

  testWidgets('the delete menu item opens the delete confirmation dialog', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(RootDrawerDatabaseCardWidget(database: db)));

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.byType(DatabaseDeleteDialogWidget), findsOneWidget);
  });
}

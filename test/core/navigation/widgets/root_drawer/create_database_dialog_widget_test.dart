import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
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

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

void main() {
  late _MockDatabaseRepository repository;
  late _MockSqlExecutionService sqlExecutionService;
  late ProviderContainer container;

  const toastChannel = MethodChannel('PonnamKarthik/fluttertoast');

  Future<void> pumpAndOpen(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => CreateDatabaseDialogWidget.show(context),
                  child: const Text('open'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  setUpAll(() {
    registerFallbackValue(DatabaseModel(label: 'fallback', name: 'fallback'));
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesService.init();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, (_) async => true);

    repository = _MockDatabaseRepository();
    sqlExecutionService = _MockSqlExecutionService();

    container = ProviderContainer(
      overrides: [
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

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, null);
  });

  testWidgets('shows a validation error when fields are left empty', (
    tester,
  ) async {
    await pumpAndOpen(tester);

    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a label'), findsOneWidget);
    expect(find.text('Please enter a name'), findsOneWidget);
    verifyNever(() => repository.getByName(any()));
  });

  testWidgets('derives a snake_case name from the label as it is typed', (
    tester,
  ) async {
    await pumpAndOpen(tester);

    await tester.enterText(find.byType(TextFormField).first, 'My Database');
    await tester.pump();

    final nameField = tester.widget<TextFormField>(
      find.byType(TextFormField).last,
    );
    expect(nameField.controller?.text, 'my_database');
  });

  testWidgets(
    'clearing the label also clears an unedited derived name field',
    (tester) async {
      await pumpAndOpen(tester);

      await tester.enterText(find.byType(TextFormField).first, 'My Database');
      await tester.pump();

      await tester.tap(find.byIcon(Icons.clear).first);
      await tester.pump();

      final nameField = tester.widget<TextFormField>(
        find.byType(TextFormField).last,
      );
      expect(nameField.controller?.text, isEmpty);
    },
  );

  testWidgets('shows an error dialog when the database name already exists', (
    tester,
  ) async {
    when(() => repository.getByName('existing')).thenAnswer(
      (_) async => SuccessResult(
        DatabaseModel(label: 'Existing', name: 'existing'),
      ),
    );

    await pumpAndOpen(tester);

    await tester.enterText(find.byType(TextFormField).first, 'Existing');
    await tester.enterText(find.byType(TextFormField).last, 'existing');
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Database "existing" already exists'), findsOneWidget);
    verifyNever(() => repository.create(any()));
  });

  testWidgets(
    'creates the database, selects it and closes the dialog on success',
    (tester) async {
      when(
        () => repository.getByName('todo_list'),
      ).thenAnswer((_) async => const SuccessResult(null));
      when(
        () => repository.create(any()),
      ).thenAnswer((_) async => const SuccessResult(null));

      await pumpAndOpen(tester);

      await tester.enterText(find.byType(TextFormField).first, 'Todo List');
      await tester.enterText(
        find.byType(TextFormField).last,
        'todo_list',
      );
      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      verify(() => repository.create(any())).called(1);
      expect(find.byType(CreateDatabaseDialogWidget), findsNothing);
      expect(
        container.read(sqlCommandsViewModelProvider).activeDatabase,
        'todo_list',
      );

      await tester.pump(const Duration(seconds: 2));
    },
  );
}

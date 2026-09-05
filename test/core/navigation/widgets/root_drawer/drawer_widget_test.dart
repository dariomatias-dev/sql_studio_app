import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/create_database_dialog_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/drawer_widget.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database/data/providers/database_data_providers.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/domain/repositories/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/usecases/delete_database_usecase.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockDatabaseRepository extends Mock implements DatabaseRepository {}

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

void main() {
  late _MockDatabaseRepository repository;
  late _MockSqlExecutionService sqlExecutionService;
  late ProviderContainer container;

  Widget wrap(Widget child) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(body: child),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(DatabaseEntity(label: 'fallback', name: 'fallback'));
  });

  setUp(() async {
    final prefs = await fakeSharedPreferencesService();

    repository = _MockDatabaseRepository();
    sqlExecutionService = _MockSqlExecutionService();

    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        databaseRepositoryProvider.overrideWithValue(repository),
        deleteDatabaseUseCaseProvider.overrideWithValue(
          DeleteDatabaseUseCase(repository, sqlExecutionService),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  testWidgets('shows the empty state when there are no databases', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const RootDrawerWidget()));

    expect(find.text('No databases yet'), findsOneWidget);
  });

  testWidgets('shows a loading indicator while databases are being loaded', (
    tester,
  ) async {
    final completer = Completer<Result<List<DatabaseEntity>>>();
    when(() => repository.getAll()).thenAnswer((_) => completer.future);

    await tester.pumpWidget(wrap(const RootDrawerWidget()));

    unawaited(
      container.read(databaseListViewModelProvider.notifier).loadDatabases(),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(const SuccessResult(<DatabaseEntity>[]));
    await tester.pumpAndSettle();
  });

  testWidgets('lists favorite and other databases once loaded', (
    tester,
  ) async {
    when(() => repository.getAll()).thenAnswer(
      (_) async => SuccessResult([
        DatabaseEntity(label: 'Todo', name: 'todo', isFavorite: true),
        DatabaseEntity(label: 'Contacts', name: 'contacts'),
      ]),
    );

    await tester.pumpWidget(wrap(const RootDrawerWidget()));

    await container
        .read(databaseListViewModelProvider.notifier)
        .loadDatabases();
    await tester.pumpAndSettle();

    expect(find.text('FAVORITES'), findsOneWidget);
    expect(find.text('ALL DATABASES'), findsOneWidget);
    expect(find.text('Todo'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
  });

  testWidgets('typing in the search field filters the list', (tester) async {
    when(() => repository.getAll()).thenAnswer(
      (_) async => SuccessResult([
        DatabaseEntity(label: 'Todo', name: 'todo'),
        DatabaseEntity(label: 'Contacts', name: 'contacts'),
      ]),
    );

    await tester.pumpWidget(wrap(const RootDrawerWidget()));

    await container
        .read(databaseListViewModelProvider.notifier)
        .loadDatabases();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'todo');
    await tester.pumpAndSettle();

    expect(find.text('Todo'), findsOneWidget);
    expect(find.text('Contacts'), findsNothing);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Todo'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
  });

  testWidgets('tapping "New Database" opens the create database dialog', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const RootDrawerWidget()));

    await tester.tap(find.text('New Database'));
    await tester.pumpAndSettle();

    expect(find.byType(CreateDatabaseDialogWidget), findsOneWidget);
  });
}

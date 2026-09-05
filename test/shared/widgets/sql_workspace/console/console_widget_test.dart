import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_editor/data/providers/sql_editor_data_providers.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  late _MockSqlCommandsRepository repository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(const DatabaseSuccess());
  });

  setUp(() async {
    final prefs = await fakeSharedPreferencesService();

    repository = _MockSqlCommandsRepository();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        sqlCommandsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
  });

  Future<void> pumpConsole(WidgetTester tester) {
    return tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: ConsoleWidget()),
        ),
      ),
    );
  }

  testWidgets('shows the empty state before any query has run', (
    tester,
  ) async {
    await pumpConsole(tester);

    expect(
      find.text('Run a query to see the results here'),
      findsOneWidget,
    );
  });

  testWidgets('shows a loading indicator while the query is running', (
    tester,
  ) async {
    await pumpConsole(tester);

    final completer = Completer<Result<DatabaseSuccess?>>();
    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer((_) => completer.future);

    final commands = container.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = 'my_db';
    unawaited(commands.runQuery('SELECT * FROM users'));
    await tester.pump();

    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    completer.complete(const SuccessResult(DatabaseSuccess(result: [])));
    await tester.pumpAndSettle();
  });

  testWidgets('shows an error message when the query fails', (tester) async {
    await pumpConsole(tester);

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer(
      (_) async => const FailureResult(
        DatabaseFailure(AppLocalizationsKey.sqlExecutionError, {
          'error': 'boom',
        }),
      ),
    );

    final commands = container.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = 'my_db';
    await commands.runQuery('SELECT * FROM users');
    await tester.pumpAndSettle();

    expect(find.textContaining('boom'), findsOneWidget);
  });

  testWidgets('shows a table with the returned rows', (tester) async {
    await pumpConsole(tester);

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer(
      (_) async => const SuccessResult(
        DatabaseSuccess(
          result: [
            {'id': 1, 'name': 'Alice'},
          ],
        ),
      ),
    );

    final commands = container.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = 'my_db';
    await commands.runQuery('SELECT * FROM users');
    await tester.pumpAndSettle();

    expect(find.byType(StyledDataTableWidget), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
  });

  testWidgets('shows the table columns for an empty SELECT result', (
    tester,
  ) async {
    await pumpConsole(tester);

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer(
      (_) async => const SuccessResult(DatabaseSuccess(result: [])),
    );
    when(
      () => repository.getTableColumns(
        databaseName: any(named: 'databaseName'),
        tableName: any(named: 'tableName'),
      ),
    ).thenAnswer((_) async => ['id', 'name']);

    final commands = container.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = 'my_db';
    await commands.runQuery('SELECT * FROM users');
    await tester.pumpAndSettle();

    expect(find.byType(StyledDataTableWidget), findsOneWidget);
    expect(find.text('id'), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
  });

  testWidgets('clearing the console restores the empty state', (
    tester,
  ) async {
    await pumpConsole(tester);

    when(
      () => repository.execute(
        sql: any(named: 'sql'),
        databaseName: any(named: 'databaseName'),
      ),
    ).thenAnswer(
      (_) async => const SuccessResult(
        DatabaseSuccess(
          result: [
            {'id': 1},
          ],
        ),
      ),
    );

    final commands = container.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = 'my_db';
    await commands.runQuery('SELECT * FROM users');
    await tester.pumpAndSettle();

    expect(find.byType(StyledDataTableWidget), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear_rounded));
    await tester.pumpAndSettle();

    expect(
      find.text('Run a query to see the results here'),
      findsOneWidget,
    );
  });
}

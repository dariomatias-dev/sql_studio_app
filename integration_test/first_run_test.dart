import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';

import 'test_helpers/app_harness.dart';

/// Covers the app's first launch: every bundled sample database seeds
/// its schema and data, and the Databases tab opens populated.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('seeds every default database on first run', (tester) async {
    final container = await pumpApp(tester);

    await tester.tap(find.byKey(const Key('rootNavBar_databases')));
    await tester.pumpAndSettle();

    expect(find.byType(DatabaseCardWidget), findsWidgets);

    final sqlExecutionService = container.read(sqlExecutionServiceProvider);

    for (final db in defaultDatabases) {
      final result = await sqlExecutionService.execute(
        sql: 'SELECT COUNT(*) AS c FROM ${db.tables.first}',
        databaseName: db.name,
      );

      expect(result, isA<SuccessResult<DatabaseSuccess?>>(), reason: db.name);

      final rows = (result as SuccessResult<DatabaseSuccess?>).value!.result!;
      expect(rows.single['c'], greaterThan(0), reason: db.name);
    }
  });
}

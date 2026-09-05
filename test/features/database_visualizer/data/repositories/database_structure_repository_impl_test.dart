import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/data/repositories/database_structure_repository_impl.dart';

class _MockSqlExecutionService extends Mock implements SqlExecutionService {}

class _MockLogger extends Mock implements AppLogger {}

void main() {
  late _MockSqlExecutionService sqlService;
  late DatabaseStructureRepositoryImpl repository;

  setUp(() {
    sqlService = _MockSqlExecutionService();
    repository = DatabaseStructureRepositoryImpl(sqlService, _MockLogger());
  });

  test('returns the tables produced by the sql service', () async {
    final tables = [
      TableInfoModel(name: 'users', columns: []),
    ];

    when(
      () => sqlService.getDatabaseStructure(databaseName: 'my_db'),
    ).thenAnswer((_) async => tables);

    final result =
        await repository.getStructure('my_db')
            as SuccessResult<List<TableInfoModel>>;

    expect(result.value, tables);
  });

  test(
    'fails with failedToLoadDatabaseStructure when the query throws',
    () async {
      when(
        () => sqlService.getDatabaseStructure(databaseName: 'my_db'),
      ).thenThrow(Exception('boom'));

      final result =
          await repository.getStructure('my_db')
              as FailureResult<List<TableInfoModel>>;

      expect(
        result.error.type,
        AppLocalizationsKey.failedToLoadDatabaseStructure,
      );
    },
  );
}

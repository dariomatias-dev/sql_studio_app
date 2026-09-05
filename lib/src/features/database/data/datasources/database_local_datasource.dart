import 'package:sql_studio/src/core/database/database_repository.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

/// Reads and writes database rows in sqflite, and manages the underlying
/// per-database SQLite files.
class DatabaseLocalDatasource {
  /// Creates the datasource, backed by [manager].
  DatabaseLocalDatasource(DatabaseManager manager)
    : _repository = DatabaseRepository<DatabaseEntity>(
        tableName: 'databases',
        manager: manager,
      );

  final DatabaseRepository<DatabaseEntity> _repository;

  /// Inserts a new row.
  Future<int> insert(Map<String, dynamic> map) => _repository.insert(map);

  /// Fetches all rows ordered by [orderBy].
  Future<List<Map<String, dynamic>>> getAll({String? orderBy}) {
    return _repository.getAll(orderBy: orderBy);
  }

  /// Fetches rows matching all the given [conditions].
  Future<List<Map<String, dynamic>>> getWhere({
    required Map<String, dynamic> conditions,
    int? limit,
  }) {
    return _repository.getWhere(conditions: conditions, limit: limit);
  }

  /// Updates an existing row.
  Future<int> update(Map<String, dynamic> map) => _repository.update(map);

  /// Deletes the row matching `map['id']`.
  Future<int> delete(Map<String, dynamic> map) => _repository.delete(map);

  /// Deletes the SQLite file for the database named [databaseName].
  Future<void> dropDatabaseFile(String databaseName) {
    return _repository.dropDatabaseFile(databaseName);
  }
}

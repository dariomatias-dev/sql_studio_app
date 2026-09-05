import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';

/// Inspects the table/column/foreign-key structure of a database.
// ignore: one_member_abstracts
abstract interface class DatabaseStructureRepository {
  /// Returns the full structure of [databaseName].
  Future<Result<List<TableInfoEntity>>> getStructure(String databaseName);
}

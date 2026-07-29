import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Inspects the table/column/foreign-key structure of a database.
// ignore: one_member_abstracts
abstract interface class DatabaseStructureRepository {
  /// Returns the full structure of [databaseName].
  Future<Result<List<TableInfoModel>>> getStructure(String databaseName);
}

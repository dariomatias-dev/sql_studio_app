import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';

/// Returns the full table/column/foreign-key structure of a database.
typedef GetStructure =
    Future<List<TableInfoModel>> Function(String databaseName);

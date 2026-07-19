import 'package:sql_studio/src/core/error/result.dart';

import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';

/// Helper logic for the SQL console widget.
class ConsoleController {
  /// Extracts the table name referenced by the last executed query in
  /// [state], when the result was an empty `SELECT`. Returns an
  /// empty string when it can't be determined.
  String extractTableName(SqlCommandsState state) {
    if (state.result is SuccessResult &&
        ((state.result! as SuccessResult).value is DatabaseSuccess) &&
        (((state.result! as SuccessResult).value as DatabaseSuccess).result
                is List &&
            (((state.result! as SuccessResult).value as DatabaseSuccess).result!
                    as List)
                .isEmpty)) {
      final sql = state.lastQuery;
      if (sql == null) return '';

      final match = RegExp(
        r'\bfrom\s+([a-zA-Z_][\w]*)\b',
        caseSensitive: false,
      ).firstMatch(sql);

      return match?.group(1) ?? '';
    }

    return '';
  }
}

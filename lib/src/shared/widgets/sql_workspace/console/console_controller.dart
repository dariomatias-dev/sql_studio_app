import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

class ConsoleController {
  String extractTableName(SqlCommandsNotifier notifier) {
    if (notifier.result is SuccessResult &&
        ((notifier.result as SuccessResult).value is DatabaseSuccess) &&
        (((notifier.result as SuccessResult).value as DatabaseSuccess).result
                is List &&
            (((notifier.result as SuccessResult).value as DatabaseSuccess)
                        .result
                    as List)
                .isEmpty)) {
      final sql = notifier.lastQuery;
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

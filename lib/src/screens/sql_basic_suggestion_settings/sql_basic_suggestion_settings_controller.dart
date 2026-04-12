import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

class SqlBasicSuggestionsController {
  final BuildContext Function() getContext;

  SqlBasicSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlBasicSuggestionsNotifier>();
  }

  late final SqlBasicSuggestionsNotifier notifier;

  Future<bool> saveOrder(List<String> suggestions) async {
    final result = await notifier.updateSuggestions(suggestions);

    return result.isSuccess;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionsController {
  final BuildContext Function() getContext;

  SqlAdvancedSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlAdvancedSuggestionsNotifier>();
  }

  late final SqlAdvancedSuggestionsNotifier notifier;

  Future<bool> saveOrder(List<SqlAdvancedSuggestionModel> suggestions) async {
    final result = await notifier.reorderSuggestions(suggestions);

    return result.isSuccess;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

/// Controller backing the advanced SQL suggestions settings screen,
/// mediating between the UI and [SqlAdvancedSuggestionsNotifier].
class SqlAdvancedSuggestionsController {
  /// Creates the controller, resolving its notifier from [getContext].
  SqlAdvancedSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlAdvancedSuggestionsNotifier>();
  }

  /// Provides the [BuildContext] used to read the notifier.
  final BuildContext Function() getContext;

  /// Notifier holding and persisting the advanced suggestions state.
  late final SqlAdvancedSuggestionsNotifier notifier;

  /// Persists the new [suggestions] order, returning whether it succeeded.
  Future<bool> saveOrder(List<SqlAdvancedSuggestionModel> suggestions) async {
    final result = await notifier.reorderSuggestions(suggestions);

    return result.isSuccess;
  }
}

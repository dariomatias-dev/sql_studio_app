import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';

/// Coordinates saving reordered basic SQL suggestions from the settings
/// screen.
class SqlBasicSuggestionsController {
  /// Creates a controller that resolves its [BuildContext] via
  /// [getContext].
  SqlBasicSuggestionsController({required this.getContext}) {
    notifier = getContext().read<SqlBasicSuggestionsNotifier>();
  }

  /// Function used to obtain the current [BuildContext] on demand.
  final BuildContext Function() getContext;

  /// Notifier holding and persisting the basic SQL suggestions.
  late final SqlBasicSuggestionsNotifier notifier;

  /// Persists the given [suggestions] order and returns whether it
  /// succeeded.
  Future<bool> saveOrder(List<String> suggestions) async {
    final result = await notifier.updateSuggestions(suggestions);

    return result.isSuccess;
  }
}

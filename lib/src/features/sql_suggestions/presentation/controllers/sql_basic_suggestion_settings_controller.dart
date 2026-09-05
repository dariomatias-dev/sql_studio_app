import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_view_model.dart';

/// Coordinates saving reordered basic SQL suggestions from the settings
/// screen.
class SqlBasicSuggestionsController {
  /// Creates a controller that resolves its view model from [ref].
  SqlBasicSuggestionsController({required WidgetRef ref})
    : _viewModel = ref.read(sqlBasicSuggestionsViewModelProvider.notifier);

  final SqlBasicSuggestionsViewModel _viewModel;

  /// Persists the given [suggestions] order and returns whether it
  /// succeeded.
  Future<bool> saveOrder(List<String> suggestions) async {
    final result = await _viewModel.updateSuggestions(suggestions);

    return result.isSuccess;
  }
}

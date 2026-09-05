import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_view_model.dart';

/// Controller backing the advanced SQL suggestions settings screen,
/// mediating between the UI and the advanced suggestions view model.
class SqlAdvancedSuggestionsController {
  /// Creates the controller, resolving its view model from [ref].
  SqlAdvancedSuggestionsController({required WidgetRef ref})
    : _viewModel = ref.read(sqlAdvancedSuggestionsViewModelProvider.notifier);

  final SqlAdvancedSuggestionsViewModel _viewModel;

  /// Persists the new [suggestions] order, returning whether it succeeded.
  Future<bool> saveOrder(List<SqlAdvancedSuggestionEntity> suggestions) async {
    final result = await _viewModel.reorderSuggestions(suggestions);

    return result.isSuccess;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/reset_sql_advanced_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SqlAdvancedSuggestionSettingsScreen extends StatefulWidget {
  const SqlAdvancedSuggestionSettingsScreen({super.key});

  @override
  State<SqlAdvancedSuggestionSettingsScreen> createState() =>
      _SqlAdvancedSuggestionSettingsScreenState();
}

class _SqlAdvancedSuggestionSettingsScreenState
    extends State<SqlAdvancedSuggestionSettingsScreen> {
  late final suggestionsOrderNotifier = ValueNotifier(
    List<SqlAdvancedSuggestionModel>.from(
      context.read<SqlAdvancedSuggestionsNotifier>().advancedSuggestions,
    ),
  );

  Future<void> _saveOrder() async {
    await context.read<SqlAdvancedSuggestionsNotifier>().reorderSuggestions(
      suggestionsOrderNotifier.value,
    );
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const CreateSqlAdvancedSuggestionDialogWidget();
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const ResetSqlAdvancedSuggestionsDialogWidget();
      },
    );
  }

  @override
  void dispose() {
    suggestionsOrderNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlAdvancedSuggestionsNotifier>();

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Advanced Suggestions'),
        actions: <Widget>[
          IconButton(
            onPressed: _showResetDialog,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: LoadingButtonWidget(text: 'Save', onPressed: _saveOrder),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: notifier.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<List<SqlAdvancedSuggestionModel>>(
              valueListenable: suggestionsOrderNotifier,
              builder: (context, suggestions, _) {
                return Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.white),
                  child: ReorderableListView(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 12.0,
                      bottom: 100.0,
                      left: 12.0,
                    ),
                    onReorder: (oldIndex, newIndex) {
                      final updated = <SqlAdvancedSuggestionModel>[
                        ...suggestions,
                      ];
                      if (newIndex > oldIndex) newIndex--;

                      final item = updated.removeAt(oldIndex);

                      updated.insert(newIndex, item);

                      suggestionsOrderNotifier.value = updated;
                    },
                    children: suggestions.builder((suggestion, index) {
                      return SqlAdvancedSuggestionCardWidget(
                        key: ValueKey(suggestion.id),
                        suggestion: suggestion,
                      );
                    }),
                  ),
                );
              },
            ),
    );
  }
}

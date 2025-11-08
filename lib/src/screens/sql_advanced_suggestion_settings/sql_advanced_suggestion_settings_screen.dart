import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/sql_advanced_suggestion_settings_controller.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/sql_advanced_suggestion_card/sql_advanced_suggestion_card_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
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
  late final _controller = SqlAdvancedSuggestionsController(context);

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchNotifier = context.watch<SqlAdvancedSuggestionsNotifier>();

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Advanced Suggestions'),
        actions: <Widget>[
          IconButton(
            onPressed: _controller.showResetDialog,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
        ],
      ),
      body: watchNotifier.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                ValueListenableBuilder<List<SqlAdvancedSuggestionModel>>(
                  valueListenable: _controller.suggestionsOrderNotifier,
                  builder: (context, suggestions, _) {
                    return Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(canvasColor: Colors.white),
                      child: ReorderableListView(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          right: 12.0,
                          bottom: 80.0,
                          left: 12.0,
                        ),
                        onReorder: (oldIndex, newIndex) {
                          _controller.reorderSuggestions(
                            suggestions,
                            oldIndex,
                            newIndex,
                          );
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
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      spacing: 12.0,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: LoadingButtonWidget(
                              text: 'Save',
                              onPressed: () => _controller.saveOrder(
                              ),
                              style: ButtonStyleType.black,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: _controller.showCreateDialog,
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

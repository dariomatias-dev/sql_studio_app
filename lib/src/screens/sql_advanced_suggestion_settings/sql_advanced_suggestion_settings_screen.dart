import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/reset_sql_advanced_suggestions_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/update_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
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

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const CreateSqlAdvancedSuggestionDialogWidget();
      },
    );
  }

  void _showEditDialog(SqlAdvancedSuggestionModel suggestion) {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: suggestion,
        );
      },
    );
  }

  void _showRemoveDialog(SqlAdvancedSuggestionModel suggestion) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteSqlAdvancedSuggestionDialogWidget(
          id: suggestion.id,
          label: suggestion.label,
        );
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

  Future<void> _saveOrder() async {
    await context.read<SqlAdvancedSuggestionsNotifier>().reorderSuggestions(
      suggestionsOrderNotifier.value,
    );
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
                      final updated = [...suggestions];
                      if (newIndex > oldIndex) newIndex--;
                      final item = updated.removeAt(oldIndex);
                      updated.insert(newIndex, item);
                      suggestionsOrderNotifier.value = updated;
                    },
                    children: <Widget>[
                      for (final suggestion in suggestions)
                        Container(
                          key: ValueKey(suggestion.id),
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withAlpha(25),
                                blurRadius: 8.0,
                                offset: const Offset(0.0, 2.0),
                              ),
                            ],
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 6.0,
                            ),
                            leading: const Icon(
                              Icons.drag_handle,
                              color: Colors.black54,
                            ),
                            title: Text(
                              suggestion.label,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            subtitle: Text(
                              suggestion.code,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  tooltip: 'Edit "${suggestion.label}"',
                                  onPressed: () => _showEditDialog(suggestion),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Delete "${suggestion.label}"',
                                  onPressed: () =>
                                      _showRemoveDialog(suggestion),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    suggestionsOrderNotifier.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/types/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/create_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/update_sql_advanced_suggestion_dialog_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SqlAdvancedSuggestionSettingsScreen extends StatefulWidget {
  const SqlAdvancedSuggestionSettingsScreen({super.key});

  @override
  State<SqlAdvancedSuggestionSettingsScreen> createState() =>
      _SqlAdvancedSuggestionSettingsScreenState();
}

class _SqlAdvancedSuggestionSettingsScreenState
    extends State<SqlAdvancedSuggestionSettingsScreen> {
  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateSqlAdvancedSuggestionDialogWidget(
          onSubmit: (value) async {
            return true;
          },
        );
      },
    );
  }

  void _showEditDialog(SqlAdvancedSuggestionModel suggestion) {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: suggestion,
          onSubmit: (value) async {
            return true;
          },
        );
      },
    );
  }

  void _showRemoveDialog(String label) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteSqlAdvancedSuggestionDialogWidget(
          label: label,
          onConfirm: () async {},
        );
      },
    );
  }

  void _showResetDialog() {}

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SqlSuggestionsNotifier>();
    final advancedSuggestions = List.of(notifier.advancedSuggestions);

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Advanced Suggestions'),
        actions: <Widget>[
          IconButton(
            onPressed: _showResetDialog,
            icon: const Icon(Icons.refresh, color: Colors.black87),
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
      body: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: ReorderableListView(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 12.0,
            bottom: 100.0,
            left: 12.0,
          ),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = advancedSuggestions.removeAt(oldIndex);
              advancedSuggestions.insert(newIndex, item);
              notifier.updateAdvancedSuggestions(advancedSuggestions);
            });
          },
          children: <Widget>[
            for (final suggestion in advancedSuggestions)
              Container(
                key: ValueKey(suggestion.label),
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
                  leading: const Icon(Icons.drag_handle, color: Colors.black54),
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
                        onPressed: () => _showRemoveDialog(suggestion.label),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/update_sql_advanced_suggestion_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionCardWidget extends StatefulWidget {
  const SqlAdvancedSuggestionCardWidget({super.key, required this.suggestion});

  final SqlAdvancedSuggestionModel suggestion;

  @override
  State<SqlAdvancedSuggestionCardWidget> createState() =>
      _SqlAdvancedSuggestionCardWidgetState();
}

class _SqlAdvancedSuggestionCardWidgetState
    extends State<SqlAdvancedSuggestionCardWidget> {
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateSqlAdvancedSuggestionDialogWidget(
          initialValue: widget.suggestion,
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteSqlAdvancedSuggestionDialogWidget(
          id: widget.suggestion.id,
          label: widget.suggestion.label,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          widget.suggestion.label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          widget.suggestion.code,
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
              tooltip: 'Edit "${widget.suggestion.label}"',
              onPressed: _showEditDialog,
              icon: Icon(Icons.edit_outlined, color: Colors.grey.shade600),
            ),
            IconButton(
              tooltip: 'Delete "${widget.suggestion.label}"',
              onPressed: _showDeleteDialog,
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

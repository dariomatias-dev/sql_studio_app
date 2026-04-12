import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/screens/sql_advanced_suggestion_settings/widgets/dialogs/update_sql_advanced_suggestion_dialog_widget.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';

class SqlAdvancedSuggestionCardWidget extends StatelessWidget {
  const SqlAdvancedSuggestionCardWidget({super.key, required this.suggestion});

  final SqlAdvancedSuggestionModel suggestion;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

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
              tooltip: appLocalizations.editSuggestion,
              onPressed: () {
                UpdateSqlAdvancedSuggestionDialogWidget.show(
                  context,
                  initialValue: suggestion,
                );
              },
              icon: Icon(Icons.edit_outlined, color: Colors.grey.shade600),
            ),
            IconButton(
              tooltip: appLocalizations.removeSuggestion,
              onPressed: () {
                DeleteSqlAdvancedSuggestionDialogWidget.show(
                  context,
                  id: suggestion.id,
                  label: suggestion.label,
                );
              },
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

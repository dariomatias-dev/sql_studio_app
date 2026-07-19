import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/dialogs/remove_sql_basic_suggestion_dialog_widget.dart';

/// Card that displays a basic SQL suggestion with a delete action.
class SqlBasicSuggestionCardWidget extends StatefulWidget {
  /// Creates a card for the given basic [suggestion].
  const SqlBasicSuggestionCardWidget({required this.suggestion, super.key});

  /// Suggestion text displayed by this card.
  final String suggestion;

  @override
  State<SqlBasicSuggestionCardWidget> createState() =>
      _SqlBasicSuggestionCardWidgetState();
}

class _SqlBasicSuggestionCardWidgetState
    extends State<SqlBasicSuggestionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: const Icon(Icons.drag_handle, color: Colors.black54),
        title: Text(
          widget.suggestion.trim(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            unawaited(
              RemoveSqlBasicSuggestionDialogWidget.show(
                context,
                suggestion: widget.suggestion,
              ),
            );
          },
          tooltip: AppLocalizations.of(context)!.deleteSuggestion,
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
        ),
      ),
    );
  }
}

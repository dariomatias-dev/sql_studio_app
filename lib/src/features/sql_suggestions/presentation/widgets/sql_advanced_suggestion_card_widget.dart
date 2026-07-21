import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/delete_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/update_sql_advanced_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';

/// Card that displays an advanced SQL suggestion with edit and delete
/// actions.
class SqlAdvancedSuggestionCardWidget extends StatelessWidget {
  /// Creates a card for the given advanced [suggestion].
  const SqlAdvancedSuggestionCardWidget({required this.suggestion, super.key});

  /// Advanced suggestion displayed by this card.
  final SqlAdvancedSuggestionModel suggestion;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CardWidget(
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
            suggestion.label,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            suggestion.code,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
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
                  unawaited(
                    UpdateSqlAdvancedSuggestionDialogWidget.show(
                      context,
                      initialValue: suggestion,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.textMuted,
                ),
              ),
              IconButton(
                tooltip: appLocalizations.removeSuggestion,
                onPressed: () {
                  unawaited(
                    DeleteSqlAdvancedSuggestionDialogWidget.show(
                      context,
                      id: suggestion.id,
                      label: suggestion.label,
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

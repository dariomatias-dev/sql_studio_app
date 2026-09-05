import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/dialogs/remove_sql_basic_suggestion_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';

/// Card that displays a basic SQL suggestion with a delete action.
class SqlBasicSuggestionCardWidget extends StatelessWidget {
  /// Creates a card for the given basic [suggestion].
  const SqlBasicSuggestionCardWidget({required this.suggestion, super.key});

  /// Suggestion text displayed by this card.
  final String suggestion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CardWidget(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.md),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 6,
          ),
          leading: Icon(Icons.drag_handle, color: context.colors.black54),
          title: Text(
            suggestion.trim(),
            style: TextStyle(
              color: context.colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              unawaited(
                RemoveSqlBasicSuggestionDialogWidget.show(
                  context,
                  suggestion: suggestion,
                ),
              );
            },
            tooltip: AppLocalizations.of(context).deleteSuggestion,
            icon: Icon(Icons.delete_outline, color: context.colors.error),
          ),
        ),
      ),
    );
  }
}

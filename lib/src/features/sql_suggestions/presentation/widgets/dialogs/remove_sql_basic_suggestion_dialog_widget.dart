import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/buttons/cancel_button_widget.dart';

/// Confirmation dialog for removing a single basic SQL suggestion.
class RemoveSqlBasicSuggestionDialogWidget extends ConsumerStatefulWidget {
  /// Creates a confirmation dialog for removing [suggestion].
  const RemoveSqlBasicSuggestionDialogWidget({
    required this.suggestion,
    super.key,
  });

  /// Suggestion that will be removed if the user confirms.
  final String suggestion;

  /// Displays this dialog for the given [suggestion] on top of [context].
  static Future<void> show(
    BuildContext context, {
    required String suggestion,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return RemoveSqlBasicSuggestionDialogWidget(suggestion: suggestion);
      },
    );
  }

  @override
  ConsumerState<RemoveSqlBasicSuggestionDialogWidget> createState() =>
      _RemoveSqlBasicSuggestionDialogWidgetState();
}

class _RemoveSqlBasicSuggestionDialogWidgetState
    extends ConsumerState<RemoveSqlBasicSuggestionDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ConfirmationDialogWidget(
      title: appLocalizations.removeSuggestion,
      description: appLocalizations.removeSuggestionDescription,
      cancelButton: const CancelButtonWidget(),
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final result = await ref
              .read(sqlBasicSuggestionsViewModelProvider.notifier)
              .remove(widget.suggestion);

          if (!mounted) return;

          if (result.isFailure) {
            await handleError(_getContext(), result);

            return;
          }

          _getContext().pop();
        },
        text: appLocalizations.remove,
        style: ButtonStyleType.red,
      ),
    );
  }
}

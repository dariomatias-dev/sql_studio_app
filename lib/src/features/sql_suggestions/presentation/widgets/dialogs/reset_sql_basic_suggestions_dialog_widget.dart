import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/confirmation_dialog_widget.dart';

/// Confirmation dialog for resetting basic SQL suggestions back to the
/// default list.
class ResetSqlBasicSuggestionsDialogWidget extends ConsumerStatefulWidget {
  /// Creates the reset confirmation dialog.
  const ResetSqlBasicSuggestionsDialogWidget({super.key});

  /// Displays this dialog on top of the given [context].
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const ResetSqlBasicSuggestionsDialogWidget();
      },
    );
  }

  @override
  ConsumerState<ResetSqlBasicSuggestionsDialogWidget> createState() =>
      _ResetSqlBasicSuggestionsDialogWidgetState();
}

class _ResetSqlBasicSuggestionsDialogWidgetState
    extends ConsumerState<ResetSqlBasicSuggestionsDialogWidget> {
  BuildContext _getContext() => context;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ConfirmationDialogWidget(
      title: appLocalizations.resetSuggestions,
      description: appLocalizations.resetSuggestionsDescription,
      confirmButton: LoadingButtonWidget(
        onPressed: () async {
          final result = await ref
              .read(sqlBasicSuggestionsViewModelProvider.notifier)
              .updateSuggestions(List<String>.from(defaultSqlBasicSuggestions));

          if (!mounted) return;

          if (result.isSuccess) {
            _getContext().pop();
          } else {
            await handleError(_getContext(), result);
          }
        },
        text: appLocalizations.reset,
        style: ButtonStyleType.black,
      ),
    );
  }
}

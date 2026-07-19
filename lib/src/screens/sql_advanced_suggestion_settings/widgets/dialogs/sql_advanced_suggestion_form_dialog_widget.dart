import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';
import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

/// Shared form dialog used to create or update an advanced SQL suggestion,
/// collecting its label, SQL code, and optional selectable text.
class SqlAdvancedSuggestionFormDialogWidget extends StatefulWidget {
  /// Creates the suggestion form dialog, prefilled with [initialValue] when
  /// editing an existing suggestion.
  const SqlAdvancedSuggestionFormDialogWidget({
    required this.onSubmit,
    required this.title,
    required this.submitText,
    super.key,
    this.initialValue,
  });

  /// Called with the built suggestion when the form is submitted; returns
  /// whether the operation succeeded.
  final Future<bool> Function(SqlAdvancedSuggestionModel value) onSubmit;

  /// Dialog title.
  final String title;

  /// Label of the submit button.
  final String submitText;

  /// Existing suggestion to prefill the form with, when editing.
  final SqlAdvancedSuggestionModel? initialValue;

  @override
  State<SqlAdvancedSuggestionFormDialogWidget> createState() =>
      _SqlAdvancedSuggestionFormDialogWidgetState();
}

class _SqlAdvancedSuggestionFormDialogWidgetState
    extends State<SqlAdvancedSuggestionFormDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  late final _labelController = TextEditingController(
    text: widget.initialValue?.label ?? '',
  );
  late final _codeController = TextEditingController(
    text: widget.initialValue?.code ?? '',
  );
  late final _selectTextController = TextEditingController(
    text: widget.initialValue?.selectText ?? '',
  );

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final value = SqlAdvancedSuggestionModel(
      id: widget.initialValue?.id,
      label: _labelController.text.trim(),
      code: _codeController.text.trim(),
      selectText: _selectTextController.text.trim().isEmpty
          ? null
          : _selectTextController.text.trim(),
      orderIndex:
          widget.initialValue?.orderIndex ??
          context.read<SqlAdvancedSuggestionsNotifier>().suggestions.length,
    );

    final success = await widget.onSubmit(value);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      title: widget.title,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputWidget(
              controller: _labelController,
              labelText: appLocalizations.label,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.fieldRequired;
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            InputWidget(
              controller: _codeController,
              labelText: appLocalizations.sqlCode,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.fieldRequired;
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            InputWidget(
              controller: _selectTextController,
              labelText: appLocalizations.selectableTextOptional,
              hintText: appLocalizations.selectableTextHint,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        const CancelButtonWidget(),
        LoadingButtonWidget(
          onPressed: _handleSubmit,
          text: widget.submitText,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

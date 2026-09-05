import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_advanced_suggestion_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

/// Shared form dialog used to create or update an advanced SQL suggestion,
/// collecting its label, SQL code, and optional selectable text.
class SqlAdvancedSuggestionFormDialogWidget extends ConsumerStatefulWidget {
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
  final Future<bool> Function(SqlAdvancedSuggestionEntity value) onSubmit;

  /// Dialog title.
  final String title;

  /// Label of the submit button.
  final String submitText;

  /// Existing suggestion to prefill the form with, when editing.
  final SqlAdvancedSuggestionEntity? initialValue;

  @override
  ConsumerState<SqlAdvancedSuggestionFormDialogWidget> createState() =>
      _SqlAdvancedSuggestionFormDialogWidgetState();
}

class _SqlAdvancedSuggestionFormDialogWidgetState
    extends ConsumerState<SqlAdvancedSuggestionFormDialogWidget> {
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

  @override
  void dispose() {
    _labelController.dispose();
    _codeController.dispose();
    _selectTextController.dispose();

    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final value = SqlAdvancedSuggestionEntity(
      id: widget.initialValue?.id,
      label: _labelController.text.trim(),
      code: _codeController.text.trim(),
      selectText: _selectTextController.text.trim().isEmpty
          ? null
          : _selectTextController.text.trim(),
      orderIndex:
          widget.initialValue?.orderIndex ??
          ref.read(sqlAdvancedSuggestionsViewModelProvider).suggestions.length,
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

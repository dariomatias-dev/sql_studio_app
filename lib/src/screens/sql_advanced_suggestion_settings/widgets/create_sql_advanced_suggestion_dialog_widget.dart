import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/types/sql_advanced_suggestion_model.dart';

import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class CreateSqlAdvancedSuggestionDialogWidget extends StatefulWidget {
  const CreateSqlAdvancedSuggestionDialogWidget({
    super.key,
    required this.onSubmit,
  });

  final Future<bool> Function(SqlAdvancedSuggestionModel value) onSubmit;

  @override
  State<CreateSqlAdvancedSuggestionDialogWidget> createState() =>
      _CreateSqlAdvancedSuggestionDialogWidgetState();
}

class _CreateSqlAdvancedSuggestionDialogWidgetState
    extends State<CreateSqlAdvancedSuggestionDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _codeController = TextEditingController();
  final _selectTextController = TextEditingController();

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final value = SqlAdvancedSuggestionModel(
      label: _labelController.text.trim(),
      code: _codeController.text.trim(),
      selectText: _selectTextController.text.trim().isEmpty
          ? null
          : _selectTextController.text.trim(),
    );

    final success = await widget.onSubmit(value);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: 'Create Advanced Suggestion',
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputWidget(
              controller: _labelController,
              labelText: 'Label',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            InputWidget(
              controller: _codeController,
              labelText: 'SQL Code',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            InputWidget(
              controller: _selectTextController,
              labelText: 'Selectable Text (optional)',
              hintText: 'Part of SQL to auto-select for user replacement',
            ),
          ],
        ),
      ),
      actions: <Widget>[
        const CancelButtonWidget(),
        LoadingButtonWidget(
          onPressed: _handleSubmit,
          text: 'Create',
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

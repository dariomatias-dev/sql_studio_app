import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/shared/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class SqlAdvancedSuggestionFormDialogWidget extends StatefulWidget {
  const SqlAdvancedSuggestionFormDialogWidget({
    super.key,
    required this.onSubmit,
    required this.title,
    this.initialValue,
    required this.submitText,
  });

  final Future<bool> Function(SqlAdvancedSuggestionModel value) onSubmit;
  final String title;
  final String submitText;
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
          context
              .read<SqlAdvancedSuggestionsNotifier>()
              .advancedSuggestions
              .length,
    );

    final success = await widget.onSubmit(value);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: widget.title,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
          text: widget.submitText,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

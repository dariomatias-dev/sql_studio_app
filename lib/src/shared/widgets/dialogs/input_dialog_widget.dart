import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

class InputDialogWidget extends StatefulWidget {
  const InputDialogWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.label,
    required this.onSubmit,
    this.validator,
    this.submitText = 'Submit',
  });

  final String title;
  final TextEditingController controller;
  final String label;
  final String? Function(String? value)? validator;
  final Future<void> Function(String value) onSubmit;
  final String submitText;

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  final formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    widget.onSubmit(widget.controller.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: widget.title,
      content: Form(
        key: formKey,
        child: InputWidget(
          controller: widget.controller,
          labelText: widget.label,
          onChanged: (value) => setState(() {}),
          validator:
              widget.validator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }

                return null;
              },
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

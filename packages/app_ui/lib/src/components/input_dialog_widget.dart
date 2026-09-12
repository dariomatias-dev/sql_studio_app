import 'package:app_ui/src/components/button_widget.dart';
import 'package:app_ui/src/components/dialog_widget.dart';
import 'package:app_ui/src/components/input_widget.dart';
import 'package:app_ui/src/components/loading_button_widget.dart';
import 'package:flutter/material.dart';

/// A dialog prompting the user for a single text input value.
class InputDialogWidget extends StatefulWidget {
  /// Creates an input dialog with the given [title], [controller],
  /// [label], [cancelButton], [submitText] and [onSubmit] callback.
  const InputDialogWidget({
    required this.title,
    required this.controller,
    required this.label,
    required this.cancelButton,
    required this.submitText,
    required this.onSubmit,
    super.key,
    this.validator,
  });

  /// Title displayed at the top of the dialog.
  final String title;

  /// Controller backing the input field.
  final TextEditingController controller;

  /// Label displayed on the input field.
  final String label;

  /// Widget dismissing the dialog without submitting.
  final Widget cancelButton;

  /// Optional validation function returning an error message, or
  /// `null` when the value is valid or no validation applies.
  final String? Function(String? value)? validator;

  /// Called with the submitted value. Return `true` to close the
  /// dialog, or `false` to keep it open.
  final Future<bool> Function(String value) onSubmit;

  /// Label of the submit button.
  final String submitText;

  /// Displays an [InputDialogWidget] with the given parameters.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required String label,
    required Widget cancelButton,
    required String submitText,
    required Future<bool> Function(String value) onSubmit,
    String? Function(String? value)? validator,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return InputDialogWidget(
          title: title,
          controller: controller,
          label: label,
          cancelButton: cancelButton,
          submitText: submitText,
          onSubmit: onSubmit,
          validator: validator,
        );
      },
    );
  }

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  final formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    final success = await widget.onSubmit(widget.controller.text);

    if (success && mounted) {
      Navigator.pop(context);
    }
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
          validator: widget.validator,
        ),
      ),
      actions: <Widget>[
        widget.cancelButton,
        LoadingButtonWidget(
          onPressed: _handleSubmit,
          text: widget.submitText,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

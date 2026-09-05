import 'package:flutter/material.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

/// A dialog prompting the user for a single text input value.
class InputDialogWidget extends StatefulWidget {
  /// Creates an input dialog with the given [title], [controller],
  /// [label] and [onSubmit] callback.
  const InputDialogWidget({
    required this.title,
    required this.controller,
    required this.label,
    required this.onSubmit,
    super.key,
    this.validator,
    this.submitText,
  });

  /// Title displayed at the top of the dialog.
  final String title;

  /// Controller backing the input field.
  final TextEditingController controller;

  /// Label displayed on the input field.
  final String label;

  /// Optional validation function returning an error message, or
  /// `null` when the value is valid.
  final String? Function(String? value)? validator;

  /// Called with the submitted value. Return `true` to close the
  /// dialog, or `false` to keep it open.
  final Future<bool> Function(String value) onSubmit;

  /// Overrides the default localized submit button label.
  final String? submitText;

  /// Displays an [InputDialogWidget] with the given parameters.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required String label,
    required Future<bool> Function(String value) onSubmit,
    String? Function(String? value)? validator,
    String? submitText,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return InputDialogWidget(
          title: title,
          controller: controller,
          label: label,
          onSubmit: onSubmit,
          validator: validator,
          submitText: submitText,
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
    final appLocalizations = AppLocalizations.of(context);

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
                  return appLocalizations.thisFieldIsRequired;
                }

                return null;
              },
        ),
      ),
      actions: <Widget>[
        const CancelButtonWidget(),
        LoadingButtonWidget(
          onPressed: _handleSubmit,
          text: widget.submitText ?? appLocalizations.submit,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

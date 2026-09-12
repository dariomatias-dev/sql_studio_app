import 'package:app_ui/src/components/dialog_widget.dart';
import 'package:flutter/material.dart';

/// A dialog asking the user to confirm or cancel an action.
class ConfirmationDialogWidget extends StatelessWidget {
  /// Creates a confirmation dialog with the given [title],
  /// [description], [cancelButton] and [confirmButton].
  const ConfirmationDialogWidget({
    required this.title,
    required this.description,
    required this.cancelButton,
    required this.confirmButton,
    super.key,
  });

  /// Title displayed at the top of the dialog.
  final String title;

  /// Descriptive body text explaining the action to confirm.
  final String description;

  /// Widget dismissing the dialog without confirming, shown alongside
  /// [confirmButton].
  final Widget cancelButton;

  /// Widget triggering the confirmed action, shown alongside
  /// [cancelButton].
  final Widget confirmButton;

  /// Displays a [ConfirmationDialogWidget] and returns the result
  /// once it's dismissed.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String description,
    required Widget cancelButton,
    required Widget confirmButton,
    bool barrierDismissible = true,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return ConfirmationDialogWidget(
          title: title,
          description: description,
          cancelButton: cancelButton,
          confirmButton: confirmButton,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title,
      content: Text(description, textAlign: TextAlign.center),
      actions: <Widget>[cancelButton, confirmButton],
    );
  }
}

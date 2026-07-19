import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

/// A dialog asking the user to confirm or cancel an action.
class ConfirmationDialogWidget extends StatelessWidget {
  /// Creates a confirmation dialog with the given [title],
  /// [description] and [confirmButton].
  const ConfirmationDialogWidget({
    required this.title,
    required this.description,
    required this.confirmButton,
    super.key,
  });

  /// Title displayed at the top of the dialog.
  final String title;

  /// Descriptive body text explaining the action to confirm.
  final String description;

  /// Widget triggering the confirmed action, shown alongside a cancel
  /// button.
  final Widget confirmButton;

  /// Displays a [ConfirmationDialogWidget] and returns the result
  /// once it's dismissed.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String description,
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
      actions: <Widget>[const CancelButtonWidget(), confirmButton],
    );
  }
}

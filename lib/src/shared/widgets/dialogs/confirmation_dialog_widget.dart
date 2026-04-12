import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  const ConfirmationDialogWidget({
    super.key,
    required this.title,
    required this.description,
    required this.confirmButton,
  });

  final String title;
  final String description;
  final Widget confirmButton;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String description,
    required Widget confirmButton,
    bool barrierDismissible = true,
  }) async {
    return await showDialog<T>(
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

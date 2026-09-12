import 'package:app_ui/src/components/button_widget.dart';
import 'package:app_ui/src/components/dialog_widget.dart';
import 'package:flutter/material.dart';

/// A dialog displaying an error message with a single dismiss button.
class ErrorDialogWidget extends StatelessWidget {
  /// Creates an error dialog with the given [title], [description]
  /// and [dismissLabel].
  const ErrorDialogWidget({
    required this.title,
    required this.description,
    required this.dismissLabel,
    super.key,
  });

  /// Title displayed at the top of the dialog.
  final String title;

  /// Descriptive body text explaining the error.
  final String description;

  /// Label of the button that dismisses the dialog.
  final String dismissLabel;

  /// Displays an [ErrorDialogWidget] with the given [title],
  /// [description] and [dismissLabel].
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required String dismissLabel,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return ErrorDialogWidget(
          title: title,
          description: description,
          dismissLabel: dismissLabel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title,
      content: Text(description, textAlign: TextAlign.center),
      actions: <Widget>[
        ButtonWidget(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyleType.red,
          text: dismissLabel,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

/// A dialog displaying an error message with a single dismiss button.
class ErrorDialogWidget extends StatelessWidget {
  /// Creates an error dialog with the given [description] and
  /// optional [title].
  const ErrorDialogWidget({required this.description, super.key, this.title});

  /// Title displayed at the top of the dialog. Defaults to the
  /// localized "error" text when omitted.
  final String? title;

  /// Descriptive body text explaining the error.
  final String description;

  /// Displays an [ErrorDialogWidget] with the given [description]
  /// and optional [title].
  static Future<void> show(
    BuildContext context, {
    required String description,
    String? title,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return ErrorDialogWidget(title: title, description: description);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title ?? AppLocalizations.of(context)!.error,
      content: Text(description, textAlign: TextAlign.center),
      actions: <Widget>[
        ButtonWidget(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyleType.red,
          text: 'Ok',
        ),
      ],
    );
  }
}

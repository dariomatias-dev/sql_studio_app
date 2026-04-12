import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({super.key, this.title, required this.description});

  final String? title;
  final String description;

  static Future<void> show(
    BuildContext context, {
    String? title,
    required String description,
  }) async {
    await showDialog(
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

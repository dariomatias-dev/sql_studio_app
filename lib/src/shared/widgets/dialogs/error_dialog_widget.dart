import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({super.key, this.title, required this.description});

  final String? title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: title ?? 'Error',
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

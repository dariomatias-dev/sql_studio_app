import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

Future<void> handleError<T>(
  BuildContext context,
  Result<T> result, {
  Future<void> Function(T value)? onSuccess,
}) async {
  await result.fold(
    onSuccess: onSuccess,
    onFailure: (error) async {
      switch (error) {
        default:
          await showDialog(
            context: context,
            builder: (context) {
              return DialogWidget(
                title: 'Error',
                content: Text(error.message),
                actions: <Widget>[
                  ButtonWidget(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyleType.red,
                    text: 'Ok',
                  ),
                ],
              );
            },
          );
      }
    },
  );
}

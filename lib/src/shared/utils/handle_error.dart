import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/extensions/localization_extension.dart';
import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

Future<void> handleError<T>(
  BuildContext context,
  Result<T> result, {
  Future<void> Function(T value)? onSuccess,
}) async {
  final appLocalizations = AppLocalizations.of(context)!;

  await result.fold(
    onSuccess: onSuccess,
    onFailure: (error) async {
      switch (error) {
        default:
          await DialogWidget.show(
            context,
            title: appLocalizations.error,
            content: Text(
              appLocalizations.key(error.type, error.args),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ButtonWidget(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyleType.red,
                text: 'Ok',
              ),
            ],
          );
      }
    },
  );
}

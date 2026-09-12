import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

/// A button that pops the current route, labeled with the localized
/// "cancel" text.
class CancelButtonWidget extends StatelessWidget {
  /// Creates a cancel button.
  const CancelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () => Navigator.pop(context),
      text: AppLocalizations.of(context).cancel,
    );
  }
}

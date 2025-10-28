import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onPressed: () => Navigator.pop(context),
      text: 'Cancel',
    );
  }
}

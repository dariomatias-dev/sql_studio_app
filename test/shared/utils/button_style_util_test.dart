import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/shared/utils/button_style_util.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

void main() {
  group('resolveButtonStyle', () {
    test('black style uses the black/white palette', () {
      final style = resolveButtonStyle(style: ButtonStyleType.black);

      expect(style.background, AppColors.black);
      expect(style.foreground, AppColors.white);
      expect(style.text, AppColors.white);
    });

    test('red style uses the error/white palette', () {
      final style = resolveButtonStyle(style: ButtonStyleType.red);

      expect(style.background, AppColors.error);
      expect(style.foreground, AppColors.white);
      expect(style.text, AppColors.white);
    });

    test('custom style falls back to black/white when no colors given', () {
      final style = resolveButtonStyle(style: ButtonStyleType.custom);

      expect(style.background, AppColors.white);
      expect(style.foreground, AppColors.black);
      expect(style.text, AppColors.black);
    });

    test('custom style uses the provided colors when given', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.custom,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.orange,
        borderColor: Colors.green,
      );

      expect(style.background, Colors.blue);
      expect(style.foreground, Colors.orange);
      expect(style.border, Colors.green);
      expect(style.text, Colors.orange);
    });

    test('black and red styles ignore any custom colors passed in', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.black,
        backgroundColor: Colors.blue,
      );

      expect(style.background, AppColors.black);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/shared/utils/button_style_util.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

void main() {
  const colors = AppColors.light;

  group('resolveButtonStyle', () {
    test('black style uses the black/white palette', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.black,
        colors: colors,
      );

      expect(style.background, colors.black);
      expect(style.foreground, colors.white);
      expect(style.text, colors.white);
    });

    test('red style uses the error/white palette', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.red,
        colors: colors,
      );

      expect(style.background, colors.error);
      expect(style.foreground, colors.white);
      expect(style.text, colors.white);
    });

    test('custom style falls back to black/white when no colors given', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.custom,
        colors: colors,
      );

      expect(style.background, colors.white);
      expect(style.foreground, colors.black);
      expect(style.text, colors.black);
    });

    test('custom style uses the provided colors when given', () {
      final style = resolveButtonStyle(
        style: ButtonStyleType.custom,
        colors: colors,
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
        colors: colors,
        backgroundColor: Colors.blue,
      );

      expect(style.background, colors.black);
    });
  });
}

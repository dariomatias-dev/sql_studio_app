import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/app_radii.dart';

/// A styled text form field used throughout the app's forms.
class InputWidget extends StatelessWidget {
  /// Creates an input field.
  const InputWidget({
    super.key,
    this.onChanged,
    this.controller,
    this.labelText,
    this.hintText = '',
    this.suffixIcon,
    this.validator,
  });

  /// Called every time the field's text changes.
  final ValueChanged<String>? onChanged;

  /// Controller backing the field's text.
  final TextEditingController? controller;

  /// Floating label text shown above the field.
  final String? labelText;

  /// Placeholder text shown when the field is empty.
  final String hintText;

  /// Optional icon displayed at the end of the field.
  final Widget? suffixIcon;

  /// Optional validation function returning an error message, or
  /// `null` when the value is valid.
  final String? Function(String? value)? validator;

  OutlineInputBorder _border(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.md),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.black,
      cursorWidth: 1,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.black.withAlpha(80),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: const TextStyle(
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.black,
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.black, width: 1.5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, width: 1.5),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        fillColor: AppColors.background,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
      ),
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      ),
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validator,
    );
  }
}

import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;

  const InputWidget({
    super.key,
    this.onChanged,
    this.controller,
    this.labelText,
    this.hintText = '',
    this.suffixIcon,
    this.validator,
  });

  OutlineInputBorder _border(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      cursorWidth: 1.0,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withAlpha(80),
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black,
        enabledBorder: _border(const Color(0xFFEEEEEE)),
        focusedBorder: _border(Colors.black, width: 1.5),
        errorBorder: _border(const Color(0xFFFF3B30), width: 1.0),
        focusedErrorBorder: _border(const Color(0xFFFF3B30), width: 1.5),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        fillColor: const Color(0xFFF8F8F8),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      ),
      onChanged: onChanged,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validator,
    );
  }
}

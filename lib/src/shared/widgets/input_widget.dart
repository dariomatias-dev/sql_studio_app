import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    this.onChanged,
    this.controller,
    this.labelText,
    this.hintText = '',
    this.suffixIcon,
    this.validator,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        labelStyle: const TextStyle(color: Colors.black),
        suffixIcon: suffixIcon,
        enabledBorder: _border(Colors.grey.shade400),
        focusedBorder: _border(Colors.black, width: 1.5),
        errorBorder: _border(Colors.red, width: 1.5),
        focusedErrorBorder: _border(Colors.red, width: 1.5),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      style: const TextStyle(color: Colors.black),
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validator,
    );
  }
}

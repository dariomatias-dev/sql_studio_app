import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/sql.dart';

class SqlEditorNotifier extends ChangeNotifier {
  final controller = CodeController(language: sql);
  final focusNode = FocusNode();

  SqlEditorNotifier() {
    controller.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);
  }

  String _lastWord = '';
  String get lastWord => _lastWord;

  bool _hasFocus = false;
  bool get hasFocus => _hasFocus;

  void _onTextChanged() {
    final text = controller.text;
    final lastWord = text.split(RegExp(r'\s+')).last.trim();

    if (_lastWord != lastWord) {
      _lastWord = lastWord;

      notifyListeners();
    }
  }

  void _onFocusChanged() {
    if (_hasFocus != focusNode.hasFocus) {
      _hasFocus = focusNode.hasFocus;

      notifyListeners();
    }
  }

  void clear() {
    controller.text = '';
    _lastWord = '';

    notifyListeners();
  }

  void insertCommand(String command, {String? selectText}) {
    final text = controller.text;
    final selection = controller.selection;

    if (text.isEmpty) {
      controller.text = command;
      if (selectText != null && command.contains(selectText)) {
        final start = command.indexOf(selectText);
        controller.selection = TextSelection(
          baseOffset: start,
          extentOffset: start + selectText.length,
        );
      } else {
        controller.selection = TextSelection.collapsed(offset: command.length);
      }

      notifyListeners();
      return;
    }

    final before = text.substring(0, selection.start);
    final after = text.substring(selection.end);
    final regex = RegExp(r'(\b\w+)$');
    final match = regex.firstMatch(before);
    final start = match != null ? match.start : selection.start;
    final newText = before.replaceRange(start, before.length, command) + after;

    controller.text = newText;

    if (selectText != null && command.contains(selectText)) {
      final selectStart = start + command.indexOf(selectText);
      controller.selection = TextSelection(
        baseOffset: selectStart,
        extentOffset: selectStart + selectText.length,
      );
    } else {
      controller.selection = TextSelection.collapsed(
        offset: start + command.length,
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    focusNode.removeListener(_onFocusChanged);
    focusNode.dispose();

    super.dispose();
  }
}

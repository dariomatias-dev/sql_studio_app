import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/sql.dart';

import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_editor_state.dart';

/// Manages the SQL editor's text controller, focus and cursor state.
class SqlEditorViewModel extends Notifier<SqlEditorState> {
  /// Controller that holds and highlights the SQL editor's text.
  late final CodeController controller;

  /// Focus node attached to the SQL editor's input field.
  late final FocusNode focusNode;

  @override
  SqlEditorState build() {
    controller = CodeController(language: sql)
      ..autocompleter.mode = Mode(disableAutodetect: true);
    focusNode = FocusNode();

    controller.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);

    ref.onDispose(() {
      controller.removeListener(_onTextChanged);
      focusNode
        ..removeListener(_onFocusChanged)
        ..dispose();
    });

    return const SqlEditorState();
  }

  void _onTextChanged() {
    final text = controller.text;
    final lastWord = text.split(RegExp(r'\s+')).last.trim();

    if (state.lastWord != lastWord) {
      state = state.copyWith(lastWord: lastWord);
    }
  }

  void _onFocusChanged() {
    if (state.hasFocus != focusNode.hasFocus) {
      state = state.copyWith(hasFocus: focusNode.hasFocus);
    }
  }

  /// Clears the editor's text and resets the tracked last word.
  void clear() {
    controller.text = '';
    state = state.copyWith(lastWord: '');
  }

  /// Inserts [command] at the cursor, optionally selecting [selectText]
  /// within the inserted text.
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
  }
}

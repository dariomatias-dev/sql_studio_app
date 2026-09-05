import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';

void main() {
  ProviderContainer buildContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    return container;
  }

  group('insertCommand', () {
    test('sets the command as the text when the editor is empty', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier)
        ..insertCommand('SELECT * FROM users;');

      expect(notifier.controller.text, 'SELECT * FROM users;');
      expect(
        notifier.controller.selection,
        const TextSelection.collapsed(offset: 'SELECT * FROM users;'.length),
      );
    });

    test('selects the placeholder text within the inserted command', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier)
        ..insertCommand(
          'SELECT * FROM table_name;',
          selectText: 'table_name',
        );

      final selection = notifier.controller.selection;
      final selected = notifier.controller.text.substring(
        selection.start,
        selection.end,
      );

      expect(selected, 'table_name');
    });

    test('replaces the partially typed word before the cursor', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier);

      notifier.controller.text = 'sel';
      notifier.controller.selection = const TextSelection.collapsed(
        offset: 3,
      );

      notifier.insertCommand('SELECT');

      expect(notifier.controller.text, 'SELECT');
    });

    test('inserts at the cursor without eating preceding whitespace', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier);

      notifier.controller.text = 'SELECT * FROM users ';
      notifier.controller.selection = const TextSelection.collapsed(
        offset: 'SELECT * FROM users '.length,
      );

      notifier.insertCommand('WHERE');

      expect(notifier.controller.text, 'SELECT * FROM users WHERE');
    });

    test('keeps text after the cursor when inserting in the middle', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier);

      notifier.controller.text = 'SELECT  FROM users';
      notifier.controller.selection = const TextSelection.collapsed(
        offset: 'SELECT '.length,
      );

      notifier.insertCommand('*');

      expect(notifier.controller.text, 'SELECT * FROM users');
    });
  });

  group('clear', () {
    test('empties the controller text and the tracked last word', () {
      final container = buildContainer();
      final notifier = container.read(sqlEditorViewModelProvider.notifier);

      notifier.controller.text = 'SELECT * FROM users;';

      notifier.clear();

      expect(notifier.controller.text, isEmpty);
      expect(container.read(sqlEditorViewModelProvider).lastWord, isEmpty);
    });
  });
}

import 'package:flutter/material.dart';

class SuggestionsSettingsLayoutController<T> {
  final BuildContext context;
  final Future<void> Function(List<T>) _onSave;

  SuggestionsSettingsLayoutController({
    required this.context,
    required Future<void> Function(List<T>) onSave,
    List<T>? initialItems,
  }) : _onSave = onSave {
    itemsNotifier = ValueNotifier<List<T>>(initialItems ?? []);
  }

  late final ValueNotifier<List<T>> itemsNotifier;

  void reorderItems(int oldIndex, int newIndex) {
    final updated = <T>[...itemsNotifier.value];

    if (newIndex > oldIndex) newIndex--;

    final item = updated.removeAt(oldIndex);

    updated.insert(newIndex, item);

    itemsNotifier.value = updated;
  }

  Future<void> saveItems() async {
    await _onSave(itemsNotifier.value);
  }

  void dispose() {
    itemsNotifier.dispose();
  }
}

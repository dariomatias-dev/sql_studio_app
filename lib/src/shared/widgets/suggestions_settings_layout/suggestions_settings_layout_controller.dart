import 'package:flutter/material.dart';

class SuggestionsSettingsLayoutController<T> {
  final BuildContext context;
  final Future<void> Function(List<T>) _onSave;
  final _initialItems = <T>[];

  SuggestionsSettingsLayoutController({
    required this.context,
    required Future<void> Function(List<T> value) onSave,
    List<T>? initialItems,
  }) : _onSave = onSave {
    _initialItems.addAll(List<T>.from(initialItems ?? <T>[]));

    updateItemsNotifier(_initialItems);
  }

  final itemsNotifier = ValueNotifier(<T>[]);
  final ValueNotifier<bool> hasChangesNotifier = ValueNotifier(false);

  void updateItemsNotifier(List<T> initialItems) {
    itemsNotifier.value = initialItems;
  }

  void reorderItems(int oldIndex, int newIndex) {
    final updated = List<T>.from(itemsNotifier.value);

    if (newIndex > oldIndex) newIndex--;

    final item = updated.removeAt(oldIndex);

    updated.insert(newIndex, item);

    itemsNotifier.value = updated;

    _checkForChanges();
  }

  Future<void> saveItems() async {
    await _onSave(itemsNotifier.value);
    hasChangesNotifier.value = false;
  }

  void _checkForChanges() {
    final current = itemsNotifier.value;
    if (current.length != _initialItems.length) {
      hasChangesNotifier.value = true;
      return;
    }

    for (int i = 0; i < current.length; i++) {
      if (current[i] != _initialItems[i]) {
        hasChangesNotifier.value = true;
        return;
      }
    }

    hasChangesNotifier.value = false;
  }

  void dispose() {
    itemsNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}

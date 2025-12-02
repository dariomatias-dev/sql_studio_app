import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

class SuggestionsSettingsLayoutController<T> {
  final BuildContext Function() getContext;
  final Future<bool> Function(List<T>) _onSave;
  final _initialItems = <T>[];

  SuggestionsSettingsLayoutController({
    required this.getContext,
    required Future<bool> Function(List<T> value) onSave,
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
    final saved = await _onSave(itemsNotifier.value);

    final appLocalizations = AppLocalizations.of(getContext())!;

    Fluttertoast.showToast(
      msg: saved
          ? appLocalizations.sortOrderSavedSuccessfully
          : appLocalizations.failedToSaveSortOrder,
    );

    hasChangesNotifier.value = !saved;
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

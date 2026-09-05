import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

/// Manages the reorderable list of suggestion items shown in a suggestions
/// settings screen, tracking unsaved changes and persisting the new order.
class SuggestionsSettingsLayoutController<T> {
  /// Creates a controller seeded with [initialItems], saving changes
  /// through [onSave].
  SuggestionsSettingsLayoutController({
    required this.getContext,
    required Future<bool> Function(List<T> value) onSave,
    List<T>? initialItems,
  }) : _onSave = onSave {
    _initialItems.addAll(List<T>.from(initialItems ?? <T>[]));

    items = _initialItems;
  }

  /// Returns the current [BuildContext], used to look up localizations
  /// when showing feedback toasts.
  final BuildContext Function() getContext;
  final Future<bool> Function(List<T>) _onSave;
  final _initialItems = <T>[];

  /// Current ordered list of suggestion items.
  final ValueNotifier<List<T>> itemsNotifier = ValueNotifier(<T>[]);

  /// Whether the current item order differs from the initial one.
  final ValueNotifier<bool> hasChangesNotifier = ValueNotifier(false);

  /// Current ordered list of suggestion items.
  List<T> get items => itemsNotifier.value;

  /// Replaces the current item list.
  set items(List<T> value) {
    itemsNotifier.value = value;
  }

  /// Replaces both the current items and the baseline they're compared
  /// against, clearing any pending unsaved-changes state.
  void setInitialItems(List<T> value) {
    _initialItems
      ..clear()
      ..addAll(value);

    itemsNotifier.value = value;
    hasChangesNotifier.value = false;
  }

  /// Moves the item at [oldIndex] to [newIndex], as reported by a
  /// reorderable list view.
  void reorderItems(int oldIndex, int newIndex) {
    final updated = List<T>.from(itemsNotifier.value);
    final targetIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;

    final item = updated.removeAt(oldIndex);

    updated.insert(targetIndex, item);

    itemsNotifier.value = updated;

    _checkForChanges();
  }

  /// Persists the current item order via the `onSave` callback and shows a
  /// success or failure toast with the result.
  Future<void> saveItems() async {
    final saved = await _onSave(itemsNotifier.value);

    final appLocalizations = AppLocalizations.of(getContext())!;

    unawaited(
      AppToast.of(getContext()).show(
        saved
            ? appLocalizations.sortOrderSavedSuccessfully
            : appLocalizations.failedToSaveSortOrder,
      ),
    );

    if (saved) {
      _initialItems
        ..clear()
        ..addAll(itemsNotifier.value);
    }

    hasChangesNotifier.value = !saved;
  }

  void _checkForChanges() {
    final current = itemsNotifier.value;
    if (current.length != _initialItems.length) {
      hasChangesNotifier.value = true;
      return;
    }

    for (var i = 0; i < current.length; i++) {
      if (current[i] != _initialItems[i]) {
        hasChangesNotifier.value = true;
        return;
      }
    }

    hasChangesNotifier.value = false;
  }

  /// Disposes the notifiers owned by this controller.
  void dispose() {
    itemsNotifier.dispose();
    hasChangesNotifier.dispose();
  }
}

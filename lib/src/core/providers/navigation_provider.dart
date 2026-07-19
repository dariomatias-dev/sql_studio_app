import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the currently selected root navigation index.
class NavigationViewModel extends Notifier<int> {
  @override
  int build() => 0;

  /// The currently selected navigation index.
  int get index => state;

  /// Updates the currently selected navigation index.
  set index(int newIndex) {
    state = newIndex;
  }
}

/// Exposes the [NavigationViewModel] and the currently selected index.
final NotifierProvider<NavigationViewModel, int> navigationViewModelProvider =
    NotifierProvider(NavigationViewModel.new);

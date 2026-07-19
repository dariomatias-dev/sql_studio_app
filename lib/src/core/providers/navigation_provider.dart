import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the currently selected root navigation index.
class NavigationViewModel extends Notifier<int> {
  @override
  int build() => 0;

  /// Updates the currently selected navigation index to [newIndex].
  void setIndex(int newIndex) {
    state = newIndex;
  }
}

/// Exposes the [NavigationViewModel] and the currently selected index.
final NotifierProvider<NavigationViewModel, int> navigationViewModelProvider =
    NotifierProvider(NavigationViewModel.new);

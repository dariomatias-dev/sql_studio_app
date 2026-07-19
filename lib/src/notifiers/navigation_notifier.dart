import 'package:flutter/material.dart';

/// Tracks the currently selected navigation index.
class NavigationNotifier extends ChangeNotifier {
  int _index = 0;

  /// The currently selected navigation index.
  int get index => _index;

  /// Updates the currently selected navigation index to [newIndex].
  void setIndex(int newIndex) {
    _index = newIndex;

    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class NavigationNotifier extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void setIndex(int newIndex) {
    _index = newIndex;

    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/services/database_service.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';

class DatabaseNotifier extends ChangeNotifier {
  final _service = DatabaseService();

  final _favorites = <DatabaseModel>[];
  final _others = <DatabaseModel>[];

  bool _isLoading = false;
  String _filter = '';

  bool get isLoading => _isLoading;

  List<DatabaseModel> get favorites => _applyFilter(_favorites);

  List<DatabaseModel> get others => _applyFilter(_others);

  Future<void> loadDatabases() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final result = await _service.getAll();
    if (result is SuccessResult<List<DatabaseModel>>) {
      _favorites
        ..clear()
        ..addAll(result.value.where((db) => db.isFavorite));

      _others
        ..clear()
        ..addAll(result.value.where((db) => !db.isFavorite));
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> create(DatabaseModel model) async {
    final result = await _service.create(model);
    if (result is SuccessResult) {
      _addToProperList(model);

      notifyListeners();
    }
  }

  Future<void> delete(DatabaseModel model) async {
    final result = await _service.delete(model);
    if (result is SuccessResult) {
      _removeFromLists(model);

      notifyListeners();
    }
  }

  Future<void> toggleFavorite(DatabaseModel model) async {
    final result = await _service.toggleFavorite(model);
    if (result is SuccessResult) {
      _removeFromLists(model);

      final updated = model.copyWith(isFavorite: !model.isFavorite);

      _addToProperList(updated);

      notifyListeners();
    }
  }

  void setFilter(String value) {
    if (_filter == value) return;
    _filter = value;
    notifyListeners();
  }

  void _addToProperList(DatabaseModel model) {
    if (model.isFavorite) {
      _favorites.add(model);
    } else {
      _others.add(model);
    }
  }

  void _removeFromLists(DatabaseModel model) {
    _favorites.removeWhere((db) => db.id == model.id);
    _others.removeWhere((db) => db.id == model.id);
  }

  List<DatabaseModel> _applyFilter(List<DatabaseModel> list) {
    if (_filter.isEmpty) return List.unmodifiable(list);

    final lower = _filter.toLowerCase();
    return list
        .where((db) => db.name.toLowerCase().contains(lower))
        .toList(growable: false);
  }
}

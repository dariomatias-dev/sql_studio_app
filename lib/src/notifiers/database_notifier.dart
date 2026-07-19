import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/services/database_service.dart';

/// Manages the list of known databases and their favorite state.
class DatabaseNotifier extends ChangeNotifier {
  final _service = DatabaseService();

  final _favorites = <DatabaseModel>[];
  final _others = <DatabaseModel>[];

  bool _isLoading = false;
  String _filter = '';

  /// Whether the databases are currently being loaded.
  bool get isLoading => _isLoading;

  /// The favorite databases, filtered by the current search filter.
  List<DatabaseModel> get favorites => _applyFilter(_favorites);

  /// The non-favorite databases, filtered by the current search filter.
  List<DatabaseModel> get others => _applyFilter(_others);

  /// Loads all databases and splits them into favorites and others.
  Future<Result<void>> loadDatabases() async {
    if (_isLoading) return const SuccessResult(null);

    _isLoading = true;
    notifyListeners();

    final result = await _service.getAll();

    _isLoading = false;

    if (result is SuccessResult<List<DatabaseModel>>) {
      _favorites
        ..clear()
        ..addAll(result.value.where((db) => db.isFavorite));

      _others
        ..clear()
        ..addAll(result.value.where((db) => !db.isFavorite));

      notifyListeners();

      return const SuccessResult(null);
    } else if (result is FailureResult<List<DatabaseModel>>) {
      notifyListeners();

      return FailureResult(DatabaseFailure(result.error.type));
    }

    notifyListeners();

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Creates a new database from [model] and adds it to the proper list.
  Future<Result<void>> create(DatabaseModel model) async {
    final result = await _service.create(model);

    if (result is SuccessResult) {
      _addToProperList(model);

      notifyListeners();

      return const SuccessResult(null);
    } else if (result is FailureResult) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Retrieves a database by its [name], or `null` if none is found.
  Future<Result<DatabaseModel?>> getByName(String name) async {
    final result = await _service.getByName(name);

    if (result is SuccessResult<DatabaseModel?>) {
      return SuccessResult(result.value);
    } else if (result is FailureResult<DatabaseModel?>) {
      return FailureResult(DatabaseFailure(result.error.type));
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Drops the underlying table and deletes [model] from the lists.
  Future<Result<void>> delete(DatabaseModel model) async {
    final dropResult = await _service.dropTable(model);

    if (dropResult is FailureResult) {
      return FailureResult(
        DatabaseFailure(dropResult.error.type, dropResult.error.args),
      );
    }

    final result = await _service.delete(model);

    if (result is SuccessResult) {
      _removeFromLists(model);

      notifyListeners();

      return const SuccessResult(null);
    } else if (result is FailureResult) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Toggles the favorite state of [model] and moves it between lists.
  Future<Result<void>> toggleFavorite(DatabaseModel model) async {
    final result = await _service.toggleFavorite(model);

    if (result is SuccessResult) {
      _removeFromLists(model);

      final updated = model.copyWith(isFavorite: !model.isFavorite);

      _addToProperList(updated);

      notifyListeners();

      return const SuccessResult(null);
    } else if (result is FailureResult) {
      return FailureResult(
        DatabaseFailure(result.error.type, result.error.args),
      );
    }

    return const FailureResult(
      DatabaseFailure(AppLocalizationsKey.unknownError),
    );
  }

  /// Updates the search filter applied to the databases lists.
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

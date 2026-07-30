import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/database/default_database_model.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/default_databases_state.dart';

/// Manages the search filter applied to the bundled default databases.
class DefaultDatabasesViewModel extends Notifier<DefaultDatabasesState> {
  @override
  DefaultDatabasesState build() => const DefaultDatabasesState();

  /// Updates the search filter.
  void setFilter(String value) {
    if (state.filter == value) return;

    state = state.copyWith(filter: value);
  }

  /// Returns the default databases matching the current filter, resolving
  /// each label through [resolveLabel].
  List<DefaultDatabaseModel> filtered(
    String Function(AppLocalizationsKey) resolveLabel,
  ) {
    final query = state.filter.trim().toLowerCase();

    if (query.isEmpty) return defaultDatabases;

    return defaultDatabases
        .where((db) => resolveLabel(db.labelKey).toLowerCase().contains(query))
        .toList();
  }
}

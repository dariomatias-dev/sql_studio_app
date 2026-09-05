import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_advanced_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_basic_suggestions_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/datasources/sql_suggestion_settings_local_datasource.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_advanced_suggestions_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_basic_suggestions_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/repositories/sql_suggestion_settings_repository_impl.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';

// ── Settings (toggles) ─────────────────────────────────────────────────

/// Provides the raw suggestion-toggle preferences datasource.
final Provider<SqlSuggestionSettingsLocalDatasource>
sqlSuggestionSettingsLocalDatasourceProvider = Provider(
  (ref) => SqlSuggestionSettingsLocalDatasource(
    ref.watch(sharedPreferencesServiceProvider),
  ),
);

/// Provides the [SqlSuggestionSettingsRepository] implementation.
final Provider<SqlSuggestionSettingsRepository>
sqlSuggestionSettingsRepositoryProvider = Provider(
  (ref) => SqlSuggestionSettingsRepositoryImpl(
    ref.watch(sqlSuggestionSettingsLocalDatasourceProvider),
    ref.watch(appLoggerProvider),
  ),
);

// ── Basic suggestions ───────────────────────────────────────────────────

/// Provides the raw basic suggestions datasource.
final Provider<SqlBasicSuggestionsLocalDatasource>
sqlBasicSuggestionsLocalDatasourceProvider = Provider(
  (ref) => SqlBasicSuggestionsLocalDatasource(
    ref.watch(sharedPreferencesServiceProvider),
  ),
);

/// Provides the [SqlBasicSuggestionsRepository] implementation.
final Provider<SqlBasicSuggestionsRepository>
sqlBasicSuggestionsRepositoryProvider = Provider(
  (ref) => SqlBasicSuggestionsRepositoryImpl(
    ref.watch(sqlBasicSuggestionsLocalDatasourceProvider),
    ref.watch(appLoggerProvider),
  ),
);

// ── Advanced suggestions ────────────────────────────────────────────────

/// Provides the raw advanced suggestions datasource.
final Provider<SqlAdvancedSuggestionsLocalDatasource>
sqlAdvancedSuggestionsLocalDatasourceProvider = Provider(
  (ref) =>
      SqlAdvancedSuggestionsLocalDatasource(ref.watch(databaseManagerProvider)),
);

/// Provides the [SqlAdvancedSuggestionsRepository] implementation.
final Provider<SqlAdvancedSuggestionsRepository>
sqlAdvancedSuggestionsRepositoryProvider = Provider(
  (ref) => SqlAdvancedSuggestionsRepositoryImpl(
    ref.watch(sqlAdvancedSuggestionsLocalDatasourceProvider),
    ref.watch(appLoggerProvider),
  ),
);

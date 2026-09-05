import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_suggestion_settings_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_sql_suggestion_settings_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

/// Manages which SQL suggestion features are enabled and persists them.
class SqlSuggestionSettingsViewModel
    extends Notifier<SqlSuggestionSettingsEntity> {
  late final LoadSqlSuggestionSettingsUseCase _loadSettings;
  late final SaveSqlSuggestionSettingsUseCase _saveSettings;

  @override
  SqlSuggestionSettingsEntity build() {
    _loadSettings = ref.read(loadSqlSuggestionSettingsUseCaseProvider);
    _saveSettings = ref.read(saveSqlSuggestionSettingsUseCaseProvider);

    return const SqlSuggestionSettingsEntity();
  }

  /// Loads the persisted suggestion settings.
  Future<Result<void>> load() async {
    final result = await _loadSettings();

    return result.when(
      onSuccess: (settings) {
        state = settings;

        return const SuccessResult(null);
      },
      onFailure: FailureResult.new,
    );
  }

  /// Persists the current suggestion settings.
  Future<Result<void>> saveSettings() => _saveSettings(state);

  /// Enables or disables basic suggestions, disabling advanced ones when
  /// [value] is `true`.
  void setBasicSuggestions({required bool value}) {
    state = state.copyWith(
      useBasicSuggestions: value,
      useAdvancedSuggestions: !value && state.useAdvancedSuggestions,
    );
  }

  /// Enables or disables advanced suggestions, disabling basic ones when
  /// [value] is `true`.
  void setAdvancedSuggestions({required bool value}) {
    state = state.copyWith(
      useAdvancedSuggestions: value,
      useBasicSuggestions: !value && state.useBasicSuggestions,
    );
  }

  /// Enables or disables character-triggered suggestions.
  void setCharacterSuggestions({required bool value}) {
    state = state.copyWith(useCharacterSuggestions: value);
  }
}

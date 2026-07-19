/// The kind of SQL autocomplete suggestions that can be enabled.
enum SuggestionType {
  /// Suggestions based on basic SQL keywords.
  basic,

  /// Suggestions based on schema-aware, advanced analysis.
  advanced,
}

/// Which SQL suggestion features are currently enabled.
class SqlSuggestionSettingsEntity {
  /// Creates the settings, defaulting to basic and character suggestions
  /// enabled.
  const SqlSuggestionSettingsEntity({
    this.useBasicSuggestions = true,
    this.useAdvancedSuggestions = false,
    this.useCharacterSuggestions = true,
  });

  /// Whether basic keyword suggestions are enabled.
  final bool useBasicSuggestions;

  /// Whether advanced, schema-aware suggestions are enabled.
  final bool useAdvancedSuggestions;

  /// Whether character-triggered suggestions are enabled.
  final bool useCharacterSuggestions;

  /// Returns a copy of this entity with the given fields replaced.
  SqlSuggestionSettingsEntity copyWith({
    bool? useBasicSuggestions,
    bool? useAdvancedSuggestions,
    bool? useCharacterSuggestions,
  }) {
    return SqlSuggestionSettingsEntity(
      useBasicSuggestions: useBasicSuggestions ?? this.useBasicSuggestions,
      useAdvancedSuggestions:
          useAdvancedSuggestions ?? this.useAdvancedSuggestions,
      useCharacterSuggestions:
          useCharacterSuggestions ?? this.useCharacterSuggestions,
    );
  }
}

/// Presentation state for the SQL editor's text and focus tracking.
class SqlEditorState {
  /// Creates the state, defaulting to no focus and an empty last word.
  const SqlEditorState({this.lastWord = '', this.hasFocus = false});

  /// The last word typed before the current cursor position.
  final String lastWord;

  /// Whether the SQL editor currently has input focus.
  final bool hasFocus;

  /// Returns a copy of this state with the given fields replaced.
  SqlEditorState copyWith({String? lastWord, bool? hasFocus}) {
    return SqlEditorState(
      lastWord: lastWord ?? this.lastWord,
      hasFocus: hasFocus ?? this.hasFocus,
    );
  }
}

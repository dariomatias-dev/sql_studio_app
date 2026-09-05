import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_editor_state.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_editor_view_model.dart';

/// Exposes the [SqlCommandsViewModel] and its [SqlCommandsState].
final NotifierProvider<SqlCommandsViewModel, SqlCommandsState>
sqlCommandsViewModelProvider = NotifierProvider(SqlCommandsViewModel.new);

/// Exposes the [SqlEditorViewModel] and its [SqlEditorState].
final NotifierProvider<SqlEditorViewModel, SqlEditorState>
sqlEditorViewModelProvider = NotifierProvider(SqlEditorViewModel.new);

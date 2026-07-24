import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/providers.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/database_visualizer_canvas_widget.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/zoom_controls_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/loading_state_widget.dart';

/// Screen that renders an interactive diagram of a database's tables and
/// their relations.
class DatabaseVisualizerScreen extends ConsumerStatefulWidget {
  /// Creates the visualizer screen for the database named [databaseName].
  const DatabaseVisualizerScreen({required this.databaseName, super.key});

  /// The name of the database whose structure is being visualized.
  final String databaseName;

  @override
  ConsumerState<DatabaseVisualizerScreen> createState() =>
      _DatabaseVisualizerScreenState();
}

class _DatabaseVisualizerScreenState
    extends ConsumerState<DatabaseVisualizerScreen> {
  final _transformationController = TransformationController();
  String? _selectedTable;

  Future<void> _loadDatabaseStructure() async {
    // Discards any structure left over from a previously visualized
    // database, since this view model is a long-lived singleton.
    ref.invalidate(databaseVisualizerViewModelProvider);

    await ref
        .read(databaseVisualizerViewModelProvider.notifier)
        .load(widget.databaseName);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadDatabaseStructure());
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tables = ref.watch(
      databaseVisualizerViewModelProvider.select((s) => s.tables),
    );

    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(
          widget.databaseName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: tables == null
            ? const LoadingStateWidget()
            : tables.isEmpty
            ? EmptyStateWidget(
                message: AppLocalizations.of(context)!.theDatabaseIsEmpty,
                icon: Icons.table_chart_outlined,
              )
            : Stack(
                children: [
                  DatabaseVisualizerCanvasWidget(
                    tables: tables,
                    transformationController: _transformationController,
                    selectedTable: _selectedTable,
                    onSelectTable: (table) {
                      setState(() => _selectedTable = table);
                    },
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: ZoomControlsWidget(
                      transformationController: _transformationController,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

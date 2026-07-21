import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_controller.dart';

/// Generic screen for reordering, saving, resetting, and adding suggestion
/// items, used by the various suggestion settings screens of the app.
class SuggestionsSettingsLayoutWidget<T> extends StatefulWidget {
  /// Creates a suggestions settings screen.
  const SuggestionsSettingsLayoutWidget({
    required this.title,
    required this.isLoading,
    required this.initialItems,
    required this.onSave,
    required this.itemBuilder,
    required this.onReset,
    required this.onAdd,
    super.key,
  });

  /// Title shown in the app bar.
  final String title;

  /// Whether the initial items are still being loaded.
  final bool isLoading;

  /// Items to populate the reorderable list with initially.
  final List<T> initialItems;

  /// Persists the reordered list, returning whether it succeeded.
  final Future<bool> Function(List<T>) onSave;

  /// Builds the widget for a single item at the given index.
  final Widget Function(T item, int index) itemBuilder;

  /// Called when the reset action is pressed.
  final VoidCallback onReset;

  /// Called when the add action is pressed.
  final VoidCallback onAdd;

  @override
  State<SuggestionsSettingsLayoutWidget<T>> createState() =>
      _SuggestionsSettingsLayoutWidgetState<T>();
}

class _SuggestionsSettingsLayoutWidgetState<T>
    extends State<SuggestionsSettingsLayoutWidget<T>> {
  late final _controller = SuggestionsSettingsLayoutController<T>(
    getContext: () => context,
    onSave: widget.onSave,
    initialItems: widget.initialItems,
  );

  @override
  void didUpdateWidget(covariant SuggestionsSettingsLayoutWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.items = widget.initialItems;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: widget.onReset,
            tooltip: appLocalizations.resetSuggestions,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
        ],
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<List<T>>(
              valueListenable: _controller.itemsNotifier,
              builder: (context, items, child) => Stack(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(canvasColor: Colors.white),
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 12,
                        bottom: 80,
                        left: 12,
                      ),
                      itemCount: items.length,
                      onReorder: _controller.reorderItems,
                      itemBuilder: (context, index) {
                        return widget.itemBuilder(items[index], index);
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _controller.hasChangesNotifier,
                                builder: (context, value, child) {
                                  return LoadingButtonWidget(
                                    onPressed: value
                                        ? _controller.saveItems
                                        : null,
                                    style: ButtonStyleType.black,
                                    text: appLocalizations.save,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          FloatingActionButton(
                            onPressed: widget.onAdd,
                            backgroundColor: AppColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            tooltip: appLocalizations.createSuggestion,
                            child: const Icon(Icons.add, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

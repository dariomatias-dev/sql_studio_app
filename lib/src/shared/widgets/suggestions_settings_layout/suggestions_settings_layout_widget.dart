import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_controller.dart';

class SuggestionsSettingsLayoutWidget<T> extends StatefulWidget {
  const SuggestionsSettingsLayoutWidget({
    super.key,
    required this.title,
    required this.isLoading,
    required this.initialItems,
    required this.onSave,
    required this.itemBuilder,
    required this.onReset,
    required this.onAdd,
  });

  final String title;
  final bool isLoading;
  final List<T> initialItems;
  final Future<bool> Function(List<T>) onSave;
  final Widget Function(T item, int index) itemBuilder;
  final VoidCallback onReset;
  final VoidCallback onAdd;

  @override
  State<SuggestionsSettingsLayoutWidget<T>> createState() =>
      _SuggestionsSettingsLayoutWidgetState<T>();
}

class _SuggestionsSettingsLayoutWidgetState<T>
    extends State<SuggestionsSettingsLayoutWidget<T>> {
  late final _controller = SuggestionsSettingsLayoutController<T>(
    context: context,
    onSave: widget.onSave,
    initialItems: widget.initialItems,
  );

  @override
  void didUpdateWidget(covariant SuggestionsSettingsLayoutWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.updateItemsNotifier(widget.initialItems);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: widget.onReset,
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
                        top: 8.0,
                        right: 12.0,
                        bottom: 80.0,
                        left: 12.0,
                      ),
                      itemCount: items.length,
                      onReorder: _controller.reorderItems,
                      itemBuilder: (context, index) {
                        return widget.itemBuilder(items[index], index);
                      },
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 48.0,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _controller.hasChangesNotifier,
                                builder: (context, value, child) {
                                  return LoadingButtonWidget(
                                    onPressed: value
                                        ? _controller.saveItems
                                        : null,
                                    style: ButtonStyleType.black,
                                    text: 'Save',
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          FloatingActionButton(
                            onPressed: widget.onAdd,
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
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

import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SuggestionsSettingsLayoutWidget<T> extends StatelessWidget {
  const SuggestionsSettingsLayoutWidget({
    super.key,
    required this.title,
    required this.isLoading,
    required this.items,
    required this.onReorder,
    required this.itemBuilder,
    required this.onReset,
    required this.onAdd,
    required this.onSave,
  });

  final String title;
  final bool isLoading;
  final List<T> items;
  final void Function(int oldIndex, int newIndex) onReorder;
  final Widget Function(T item, int index) itemBuilder;
  final VoidCallback onReset;
  final VoidCallback onAdd;
  final Future<void> Function() onSave;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.refresh, color: Colors.black87),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
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
                    onReorder: onReorder,
                    itemBuilder: (context, index) =>
                        itemBuilder(items[index], index),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
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
                            child: LoadingButtonWidget(
                              onPressed: onSave,
                              style: ButtonStyleType.black,
                              text: 'Save',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        FloatingActionButton(
                          onPressed: onAdd,
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
    );
  }
}

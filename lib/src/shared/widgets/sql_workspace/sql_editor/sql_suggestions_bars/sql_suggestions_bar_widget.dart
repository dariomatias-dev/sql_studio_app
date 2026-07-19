import 'package:flutter/material.dart';

/// Base layout for a horizontally scrollable row of tappable suggestion
/// chips, shared by the SQL suggestions bar variants.
class SqlSuggestionsBarBaseWidget extends StatelessWidget {
  /// Creates a suggestions bar with [itemCount] chips built by
  /// [itemBuilder].
  const SqlSuggestionsBarBaseWidget({
    required this.onTap,
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.itemPadding,
  });

  /// Called with the tapped item's index.
  final void Function(int index) onTap;

  /// Number of suggestion chips to render.
  final int itemCount;

  /// Padding applied inside each suggestion chip.
  final EdgeInsets? itemPadding;

  /// Returns the label text for the chip at the given index.
  final String Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 4),
        itemBuilder: (context, index) {
          final suggestion = itemBuilder(index);

          return InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => onTap(index),
            child: Container(
              alignment: Alignment.center,
              padding:
                  itemPadding ??
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                suggestion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  height: 1.1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

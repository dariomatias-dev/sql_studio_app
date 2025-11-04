import 'package:flutter/material.dart';

class SqlSuggestionsBarBaseWidget extends StatelessWidget {
  const SqlSuggestionsBarBaseWidget({
    super.key,
    required this.onTap,
    required this.itemCount,
    this.itemPadding,
    required this.itemBuilder,
  });

  final void Function(int index) onTap;
  final int itemCount;
  final EdgeInsets? itemPadding;
  final String Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: 48.0,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 4.0),
        itemBuilder: (context, index) {
          final suggestion = itemBuilder(index);

          return InkWell(
            borderRadius: BorderRadius.circular(6.0),
            onTap: () => onTap(index),
            child: Container(
              alignment: Alignment.center,
              padding:
                  itemPadding ??
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Text(
                suggestion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 11.0,
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

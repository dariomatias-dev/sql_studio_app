import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/types/table_info.dart';

class DatabaseVisualizerTableWidget extends StatelessWidget {
  const DatabaseVisualizerTableWidget({super.key, required this.table});

  final TableInfo table;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Text(
              table.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          ...table.columns.map((column) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    column.name,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    column.type,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:sql_studio/src/shared/models/table_info_model.dart';

class DatabaseVisualizerTableWidget extends StatelessWidget {
  final TableInfoModel table;

  const DatabaseVisualizerTableWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 20.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 16.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.table_chart_rounded,
                  color: Colors.white,
                  size: 18.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    table.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...table.columns.map((column) {
            final isFk = column.foreignTable != null;

            return Container(
              height: 44.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  if (isFk)
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.link_rounded,
                        size: 16.0,
                        color: Color(0xFF757575),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      column.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    column.type.toLowerCase(),
                    style: TextStyle(
                      color: Colors.black.withAlpha(100),
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}

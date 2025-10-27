import 'package:flutter/material.dart';

const _sqlCommands = <String>[
  'SELECT * FROM ',
  'INSERT INTO ',
  'UPDATE ',
  'DELETE FROM ',
  'CREATE TABLE ',
  'DROP TABLE ',
  'ALTER TABLE ',
  'WHERE ',
  'GROUP BY ',
  'ORDER BY ',
  'JOIN ',
  'LEFT JOIN ',
  'RIGHT JOIN ',
  'INNER JOIN ',
  'UNION ',
  'LIMIT ',
  'OFFSET ',
];

class SqlCommandBarWidget extends StatelessWidget {
  const SqlCommandBarWidget({super.key, required this.onInsertCommand});

  final ValueChanged<String> onInsertCommand;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        scrollDirection: Axis.horizontal,
        itemCount: _sqlCommands.length,
        itemBuilder: (context, index) {
          final cmd = _sqlCommands[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 10.0,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () => onInsertCommand(cmd),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  cmd.trim(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

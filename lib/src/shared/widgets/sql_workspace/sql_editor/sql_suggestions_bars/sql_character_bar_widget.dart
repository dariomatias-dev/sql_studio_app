import 'package:flutter/material.dart';

const characters = <String>['(', ')', ';', '!', '=', '*', '%', '\'', '"'];

class SqlCharacterBarWidget extends StatelessWidget {
  const SqlCharacterBarWidget({super.key, required this.onInsertCommand});

  final void Function(String command, {String? selectText}) onInsertCommand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < characters.length; i++) ...<Widget>[
              GestureDetector(
                onTap: () => onInsertCommand(characters[i]),
                child: Container(
                  width: 44.0,
                  height: 32.0,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      characters[i],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'monospace',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              if (i < characters.length - 1)
                Container(
                  height: 20.0,
                  width: 1.0,
                  color: Colors.grey.shade400,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

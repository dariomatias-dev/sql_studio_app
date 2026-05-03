import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/extensions/list_extension.dart';

class DialogWidget extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<Widget>? actions;

  const DialogWidget({
    super.key,
    this.title,
    required this.content,
    this.actions,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) async {
    return await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return DialogWidget(title: title, content: content, actions: actions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 40.0,
              offset: const Offset(0.0, 20.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null) ...<Widget>[
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black.withAlpha(140),
                    fontSize: 16.0,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  child: content,
                ),
              ),
            ),
            if (actions != null && actions!.isNotEmpty) ...<Widget>[
              const SizedBox(height: 40.0),
              Row(
                spacing: 12.0,
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!.builder((action, index) {
                  return Expanded(child: action);
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

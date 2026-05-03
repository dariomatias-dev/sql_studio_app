import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/app_version_notifier.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String version = context.watch<AppVersionNotifier>().version;

    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.0),
      ),
      child: Text(
        'BUILD v$version',
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w800,
          color: Color(0xFF8E8E8E),
          letterSpacing: 0.5,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/routes/router_config.dart';

class SqlStudioApp extends StatelessWidget {
  const SqlStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SQL Studio',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

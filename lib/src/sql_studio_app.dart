import 'package:flutter/material.dart';

import 'package:sql_studio/src/screen/home/home_screen.dart';

class SqlStudioApp extends StatelessWidget {
  const SqlStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SQL Studio',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

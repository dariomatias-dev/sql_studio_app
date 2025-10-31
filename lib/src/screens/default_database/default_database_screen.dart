import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultDatabaseScreen extends StatelessWidget {
  const DefaultDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
            size: 20.0,
          ),
          onPressed: context.pop,
        ),
        title: const Text('Database', style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}

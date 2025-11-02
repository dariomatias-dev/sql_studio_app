import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                size: 80.0,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Screen Not Found',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'The screen you are looking for does not exist or has been moved.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
              const SizedBox(height: 20.0),
              ButtonWidget(
                onPressed: () => context.go('/'),
                style: ButtonStyleType.red,
                text: 'Go Home',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

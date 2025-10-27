import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void initState() {
    super.initState();

    _loadResources();
  }

  Future<void> _loadResources() async {}

  @override
  void dispose() {
    _rotationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  RotationTransition(
                    turns: _rotationController,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.storage_rounded,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'SQL Studio',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: 150.0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white.withAlpha(30),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

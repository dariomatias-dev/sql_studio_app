import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/result.dart';
import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/notifiers/app_version_notifier.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';

import 'package:sql_studio/src/services/database/default_database_service.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';

import 'package:sql_studio/src/shared/utils/handle_error.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _iconRotationController;
  late final AnimationController _entryAnimationController;
  late final AnimationController _gradientAnimationController;

  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _textOpacityAnimation;
  late final Animation<double> _progressOpacityAnimation;
  late final Animation<AlignmentGeometry> _gradientAlignmentAnimation;

  Future<void> _loadResources() async {
    await SharedPreferencesService.init();

    if (!mounted) return;

    final versionResult = await context.read<AppVersionNotifier>().load();

    if (!mounted) return;

    if (versionResult is FailureResult) {
      await handleError(context, versionResult);
    }

    if (!mounted) return;

    final suggestionsResult = await context
        .read<SqlSuggestionsNotifier>()
        .load();

    if (!mounted) return;

    if (suggestionsResult is FailureResult) {
      await handleError(context, suggestionsResult);
    }

    if (!mounted) return;

    final dbResult = await context.read<DatabaseNotifier>().loadDatabases();

    if (!mounted) return;

    if (dbResult is FailureResult) {
      await handleError(context, dbResult);
    }

    if (!mounted) return;

    final sqlAdvancedSuggestionsResult = await context
        .read<SqlAdvancedSuggestionsNotifier>()
        .load();

    if (!mounted) return;

    if (sqlAdvancedSuggestionsResult is FailureResult) {
      await handleError(context, sqlAdvancedSuggestionsResult);
    }

    if (!mounted) return;

    final sqlBasicSuggestionsResult = await context
        .read<SqlBasicSuggestionsNotifier>()
        .load();

    if (!mounted) return;

    if (sqlBasicSuggestionsResult is FailureResult) {
      await handleError(context, sqlBasicSuggestionsResult);
    }

    await DefaultDatabaseService.init();

    if (mounted) {
      context
          .read<SqlCommandsNotifier>()
          .activeDatabase = SharedPreferencesService.getStringOrNull(
        SharedPreferencesKeys.selectedDatabaseKey,
      );

      context.read<WorkspaceLayoutNotifier>().load();

      context.go(RouteNames.main);
    }
  }

  void _init() {
    _iconRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _iconScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _progressOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _gradientAlignmentAnimation = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
        ).chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topCenter,
          end: Alignment.topLeft,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 1,
      ),
    ]).animate(_gradientAnimationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _entryAnimationController.forward().whenComplete(() {
        _loadResources();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _iconRotationController.dispose();
    _entryAnimationController.dispose();
    _gradientAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _gradientAlignmentAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: _gradientAlignmentAnimation.value,
                radius: 1.5,
                colors: const <Color>[Color(0xFF100030), Color(0xFF010103)],
                stops: const <double>[0.0, 1.0],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ScaleTransition(
                    scale: _iconScaleAnimation,
                    child: FadeTransition(
                      opacity: _textOpacityAnimation,
                      child: SizedBox(
                        width: 140.0,
                        height: 140.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            RotationTransition(
                              turns: _iconRotationController.drive(
                                Tween(begin: 0.0, end: 0.5),
                              ),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: const Color(
                                        0xFF00E5FF,
                                      ).withAlpha(80),
                                      blurRadius: 88.0,
                                      spreadRadius: -5.0,
                                    ),
                                  ],
                                  gradient: RadialGradient(
                                    colors: <Color>[
                                      const Color(0xFF00E5FF).withAlpha(50),
                                      const Color(0xFF00E5FF).withAlpha(0),
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            RotationTransition(
                              turns: _iconRotationController.drive(
                                Tween(begin: 0.0, end: 1.0),
                              ),
                              child: Container(
                                width: 130.0,
                                height: 130.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00B0FF,
                                    ).withAlpha(178),
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/icons/sql_studio_icon_transparent.png',
                              width: 100.0,
                              height: 100.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: const Text(
                      'SQL Studio',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 2.5,
                        shadows: <Shadow>[
                          Shadow(
                            color: Color(0xFF00E5FF),
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.0),
                          ),
                          Shadow(
                            color: Colors.white30,
                            blurRadius: 5.0,
                            offset: Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  FadeTransition(
                    opacity: _progressOpacityAnimation,
                    child: SizedBox(
                      width: 250.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: LinearProgressIndicator(
                          minHeight: 10.0,
                          backgroundColor: Colors.white.withAlpha(38),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF00E5FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  FadeTransition(
                    opacity: _progressOpacityAnimation,
                    child: const Text(
                      'Loading data...',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

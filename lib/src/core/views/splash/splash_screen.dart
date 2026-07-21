import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/routes/app_routes.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';

/// Initial screen shown while the app loads its persisted state, plays an
/// entry animation, and then navigates to the main screen.
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates the splash screen.
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _iconRotationController;
  late final AnimationController _entryAnimationController;
  late final AnimationController _gradientAnimationController;

  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _textOpacityAnimation;
  late final Animation<double> _progressOpacityAnimation;
  late final Animation<AlignmentGeometry> _gradientAlignmentAnimation;

  Future<void> _loadResources() async {
    final versionResult = await ref
        .read(appVersionViewModelProvider.notifier)
        .load();

    if (!mounted) return;

    if (versionResult is FailureResult) {
      await handleError(context, versionResult);
    }

    if (!mounted) return;

    final suggestionsResult = await ref
        .read(sqlSuggestionSettingsViewModelProvider.notifier)
        .load();

    if (!mounted) return;

    if (suggestionsResult is FailureResult) {
      await handleError(context, suggestionsResult);
    }

    if (!mounted) return;

    final dbResult = await ref
        .read(databaseListViewModelProvider.notifier)
        .loadDatabases();

    if (!mounted) return;

    if (dbResult is FailureResult) {
      await handleError(context, dbResult);
    }

    if (!mounted) return;

    final sqlAdvancedSuggestionsResult = await ref
        .read(sqlAdvancedSuggestionsViewModelProvider.notifier)
        .load();

    if (!mounted) return;

    if (sqlAdvancedSuggestionsResult is FailureResult) {
      await handleError(context, sqlAdvancedSuggestionsResult);
    }

    if (!mounted) return;

    final sqlBasicSuggestionsResult = await ref
        .read(sqlBasicSuggestionsViewModelProvider.notifier)
        .load();

    if (!mounted) return;

    if (sqlBasicSuggestionsResult is FailureResult) {
      await handleError(context, sqlBasicSuggestionsResult);
    }

    final defaultDatabaseInitResult = await DefaultDatabaseService.init();

    if (!mounted) return;

    if (defaultDatabaseInitResult is FailureResult) {
      await handleError(context, defaultDatabaseInitResult);
    }

    if (!mounted) return;

    ref
        .read(sqlCommandsViewModelProvider.notifier)
        .activeDatabase = SharedPreferencesService.getStringOrNull(
      SharedPreferencesKeys.selectedDatabaseKey,
    );

    AppRoutes.goToMain(context);
  }

  void _init() {
    _iconRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat().ignore();

    _entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _iconScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.4, 1, curve: Curves.easeOut),
      ),
    );

    _progressOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.7, 1, curve: Curves.easeOut),
      ),
    );

    _gradientAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true).ignore();

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
      unawaited(
        _entryAnimationController.forward().whenComplete(_loadResources),
      );
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
                colors: const <Color>[Color(0xFF0A0A0A), Colors.black],
                stops: const <double>[0, 1],
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
                        width: 140,
                        height: 140,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            RotationTransition(
                              turns: _iconRotationController.drive(
                                Tween(begin: 0, end: 0.5),
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.white.withAlpha(80),
                                      blurRadius: 88,
                                      spreadRadius: -5,
                                    ),
                                  ],
                                  gradient: RadialGradient(
                                    colors: <Color>[
                                      Colors.white.withAlpha(50),
                                      Colors.white.withAlpha(0),
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            RotationTransition(
                              turns: _iconRotationController.drive(
                                Tween(begin: 0, end: 1),
                              ),
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withAlpha(178),
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/icons/sql_studio_icon_transparent.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: const Text(
                      'SQL Studio',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 2.5,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.white54,
                            blurRadius: 15,
                          ),
                          Shadow(
                            color: Colors.white30,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  FadeTransition(
                    opacity: _progressOpacityAnimation,
                    child: SizedBox(
                      width: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          backgroundColor: Colors.white.withAlpha(38),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeTransition(
                    opacity: _progressOpacityAnimation,
                    child: Text(
                      AppLocalizations.of(context)!.loading,
                      style: const TextStyle(
                        fontSize: 18,
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

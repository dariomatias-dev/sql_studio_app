import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
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
  late final AnimationController _entryAnimationController;

  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _textOpacityAnimation;
  late final Animation<double> _progressOpacityAnimation;

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
    _entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _iconScaleAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0, 0.75, curve: Curves.elasticOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.35, 0.9, curve: Curves.easeOut),
      ),
    );

    _progressOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.65, 1, curve: Curves.easeOut),
      ),
    );

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
    _entryAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: CustomPaint(painter: _DotGridPainter()),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ScaleTransition(
                  scale: _iconScaleAnimation,
                  child: FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: Image.asset(
                      'assets/icons/sql_studio_icon_transparent.png',
                      width: 132,
                      height: 132,
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                FadeTransition(
                  opacity: _textOpacityAnimation,
                  child: const Text(
                    'SQL Studio',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                FadeTransition(
                  opacity: _progressOpacityAnimation,
                  child: SizedBox(
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        minHeight: 4,
                        backgroundColor: AppColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _progressOpacityAnimation,
                  child: Text(
                    AppLocalizations.of(context)!.loading,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Faint dotted grid backdrop evoking a database/table structure.
class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  static const double _spacing = 28;
  static const double _dotRadius = 1.1;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.border;

    for (var y = _spacing / 2; y < size.height; y += _spacing) {
      for (var x = _spacing / 2; x < size.width; x += _spacing) {
        canvas.drawCircle(Offset(x, y), _dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => false;
}

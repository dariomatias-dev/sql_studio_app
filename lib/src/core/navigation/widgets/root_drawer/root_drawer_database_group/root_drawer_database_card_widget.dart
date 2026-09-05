import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_radii.dart';
import 'package:sql_studio/src/core/app_spacing.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/extensions/build_context_extension.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/database_delete_dialog_widget.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/presentation/database_providers.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/sql_editor_providers.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

/// Drawer list item representing a single database, with actions to
/// select, favorite, and delete it.
class RootDrawerDatabaseCardWidget extends ConsumerStatefulWidget {
  /// Creates a database card for the given [database].
  const RootDrawerDatabaseCardWidget({required this.database, super.key});

  /// The database this card represents.
  final DatabaseEntity database;

  @override
  ConsumerState<RootDrawerDatabaseCardWidget> createState() =>
      _RootDrawerDatabaseCardWidgetState();
}

class _RootDrawerDatabaseCardWidgetState
    extends ConsumerState<RootDrawerDatabaseCardWidget> {
  late bool _isFavorite = widget.database.isFavorite;

  void _selectDatabase() {
    ref.read(sqlCommandsViewModelProvider.notifier)
      ..activeDatabase = widget.database.label
      ..clearResult();

    ref.read(navigationViewModelProvider.notifier).index = 0;
    ref.read(sqlEditorViewModelProvider.notifier).focusNode.requestFocus();

    Scaffold.of(context).closeDrawer();
  }

  Future<void> _onDeleteDatabase() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await ref
        .read(databaseListViewModelProvider.notifier)
        .delete(widget.database);

    if (!mounted) return;

    if (result.isSuccess) {
      final commands = ref.read(sqlCommandsViewModelProvider.notifier);
      if (commands.activeDatabase == widget.database.name) {
        commands.activeDatabase = null;

        await ref
            .read(sharedPreferencesServiceProvider)
            .remove(SharedPreferencesKeys.selectedDatabaseKey);

        if (!mounted) return;
      }

      context.pop();

      unawaited(AppToast.of(context).show(l10n.databaseDeletedSuccessfully));
    } else {
      await handleError(context, result);
    }
  }

  Future<void> _onToggleFavorite() async {
    setState(() => _isFavorite = !_isFavorite);

    final result = await ref
        .read(databaseListViewModelProvider.notifier)
        .toggleFavorite(widget.database);

    if (!mounted) return;

    if (result.isFailure) {
      setState(() => _isFavorite = !_isFavorite);

      await handleError(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final commandsState = ref.watch(sqlCommandsViewModelProvider);
    final isActive = commandsState.activeDatabase == widget.database.label;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: isActive ? context.colors.black : context.colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        child: InkWell(
          onTap: _selectDatabase,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.sm),
              border: Border.all(
                color: isActive ? context.colors.black : context.colors.border,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.dns_rounded,
                  size: 20,
                  color: isActive
                      ? context.colors.white
                      : context.colors.textMuted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.database.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isActive
                              ? context.colors.white
                              : context.colors.black,
                        ),
                      ),
                      Text(
                        widget.database.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isActive
                              ? context.colors.white.withAlpha(160)
                              : context.colors.controlInactive,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButtonWidget(
                  iconColor: isActive
                      ? context.colors.white
                      : context.colors.black87,
                  items: <PopupMenuItem<void>>[
                    PopupMenuItem<void>(
                      onTap: _onToggleFavorite,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            _isFavorite
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 18,
                            color: context.colors.black,
                          ),
                          const SizedBox(width: 12),
                          Text(_isFavorite ? l10n.unfavorite : l10n.favorite),
                        ],
                      ),
                    ),
                    PopupMenuItem<void>(
                      onTap: () {
                        unawaited(
                          DatabaseDeleteDialogWidget.show(
                            context,
                            onDeleteDatabase: _onDeleteDatabase,
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: context.colors.error,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.delete,
                            style: TextStyle(color: context.colors.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/sql_suggestion_settings_card_widget.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/widgets/sql_suggestion_settings_title_option_widget.dart';

import 'package:sql_studio/src/shared/utils/app_toast.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

/// Screen where the user enables or disables the available SQL suggestion
/// modes.
class SqlSuggestionSettingsScreen extends ConsumerStatefulWidget {
  /// Creates the SQL suggestion settings screen.
  const SqlSuggestionSettingsScreen({super.key});

  @override
  ConsumerState<SqlSuggestionSettingsScreen> createState() =>
      _SqlSuggestionSettingsScreenState();
}

class _SqlSuggestionSettingsScreenState
    extends ConsumerState<SqlSuggestionSettingsScreen> {
  final _hasChangesNotifier = ValueNotifier<bool>(false);

  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  bool get _hasChanges {
    final settings = ref.read(sqlSuggestionSettingsViewModelProvider);

    return _useBasicSuggestions != settings.useBasicSuggestions ||
        _useAdvancedSuggestions != settings.useAdvancedSuggestions ||
        _useCharacterSuggestions != settings.useCharacterSuggestions;
  }

  Future<void> _onSave() async {
    final l10n = AppLocalizations.of(context)!;
    final settingsViewModel = ref.read(
      sqlSuggestionSettingsViewModelProvider.notifier,
    );
    final advancedViewModel = ref.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final previousAdvancedEnabled = ref
        .read(sqlSuggestionSettingsViewModelProvider)
        .useAdvancedSuggestions;

    if (!previousAdvancedEnabled &&
        _useAdvancedSuggestions &&
        ref.read(sqlAdvancedSuggestionsViewModelProvider).suggestions.isEmpty) {
      final result = await advancedViewModel.resetSuggestions();

      unawaited(
        AppToast.show(
          result.isSuccess
              ? l10n.advancedSuggestionsInitialized
              : l10n.advancedSuggestionsFailed,
        ),
      );
    }

    settingsViewModel
      ..setBasicSuggestions(value: _useBasicSuggestions)
      ..setAdvancedSuggestions(value: _useAdvancedSuggestions)
      ..setCharacterSuggestions(value: _useCharacterSuggestions);

    await settingsViewModel.saveSettings();

    if (!mounted) return;

    _hasChangesNotifier.value = _hasChanges;

    unawaited(AppToast.show(l10n.settingsSavedSuccessfully));
  }

  @override
  void initState() {
    super.initState();

    final settings = ref.read(sqlSuggestionSettingsViewModelProvider);

    _useBasicSuggestions = settings.useBasicSuggestions;
    _useAdvancedSuggestions = settings.useAdvancedSuggestions;
    _useCharacterSuggestions = settings.useCharacterSuggestions;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      appBar: AppBar(title: Text(l10n.suggestionSettings)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 32),
            SqlSuggestionSettingsTitleOptionWidget(
              title: l10n.suggestionModes,
            ),
            const SizedBox(height: 16),
            SqlSuggestionSettingsCardWidget(
              title: l10n.basicSuggestions,
              subtitle: l10n.basicSuggestionsDescription,
              active: _useBasicSuggestions,
              onChanged: (value) {
                setState(() {
                  _useBasicSuggestions = value;
                  if (value) _useAdvancedSuggestions = false;
                  _hasChangesNotifier.value = _hasChanges;
                });
              },
              onConfigure: _useBasicSuggestions
                  ? () => AppRoutes.goToSqlBasicSettings(context)
                  : null,
            ),
            const SizedBox(height: 12),
            SqlSuggestionSettingsCardWidget(
              title: l10n.advancedSuggestions,
              subtitle: l10n.advancedSuggestionsDescription,
              active: _useAdvancedSuggestions,
              onChanged: (value) {
                setState(() {
                  _useAdvancedSuggestions = value;
                  if (value) _useBasicSuggestions = false;
                  _hasChangesNotifier.value = _hasChanges;
                });
              },
              onConfigure: _useAdvancedSuggestions
                  ? () => AppRoutes.goToSqlAdvancedSettings(context)
                  : null,
            ),
            const SizedBox(height: 32),
            SqlSuggestionSettingsTitleOptionWidget(
              title: l10n.otherSuggestions,
            ),
            const SizedBox(height: 16),
            SqlSuggestionSettingsCardWidget(
              title: l10n.characterSuggestions,
              subtitle: l10n.characterSuggestionsDescription,
              active: _useCharacterSuggestions,
              onChanged: (value) {
                setState(() {
                  _useCharacterSuggestions = value;
                  _hasChangesNotifier.value = _hasChanges;
                });
              },
            ),
            const Spacer(),
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ValueListenableBuilder(
                  valueListenable: _hasChangesNotifier,
                  builder: (context, value, child) {
                    return LoadingButtonWidget(
                      onPressed: _hasChanges ? _onSave : null,
                      text: l10n.saveSettings,
                      style: ButtonStyleType.black,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_card_widget.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_title_option_widget.dart';

import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class SqlSuggestionSettingsScreen extends StatefulWidget {
  const SqlSuggestionSettingsScreen({super.key});

  @override
  State<SqlSuggestionSettingsScreen> createState() =>
      _SqlSuggestionSettingsScreenState();
}

class _SqlSuggestionSettingsScreenState
    extends State<SqlSuggestionSettingsScreen> {
  final _hasChangesNotifier = ValueNotifier(false);

  bool _useBasicSuggestions = true;
  bool _useAdvancedSuggestions = false;
  bool _useCharacterSuggestions = true;

  bool get _hasChanges {
    final notifier = context.read<SqlSuggestionsNotifier>();

    return _useBasicSuggestions != notifier.useBasicSuggestions ||
        _useAdvancedSuggestions != notifier.useAdvancedSuggestions ||
        _useCharacterSuggestions != notifier.useCharacterSuggestions;
  }

  Future<void> _onSave() async {
    final appLocalizations = AppLocalizations.of(context)!;

    final notifier = context.read<SqlSuggestionsNotifier>();
    final advancedNotifier = context.read<SqlAdvancedSuggestionsNotifier>();

    final previousAdvancedEnabled = notifier.useAdvancedSuggestions;

    if (!previousAdvancedEnabled &&
        _useAdvancedSuggestions &&
        advancedNotifier.suggestions.isEmpty) {
      final result = await advancedNotifier.resetSuggestions();

      Fluttertoast.showToast(
        msg: result.isSuccess
            ? appLocalizations.advancedSuggestionsInitialized
            : appLocalizations.advancedSuggestionsFailed,
      );
    }

    notifier.setBasicSuggestions(_useBasicSuggestions);
    notifier.setAdvancedSuggestions(_useAdvancedSuggestions);
    notifier.setCharacterSuggestions(_useCharacterSuggestions);

    await notifier.saveSettings();

    if (!mounted) return;

    _hasChangesNotifier.value = _hasChanges;

    Fluttertoast.showToast(msg: appLocalizations.settingsSavedSuccessfully);
  }

  @override
  void initState() {
    super.initState();

    final notifier = context.read<SqlSuggestionsNotifier>();

    _useBasicSuggestions = notifier.useBasicSuggestions;
    _useAdvancedSuggestions = notifier.useAdvancedSuggestions;
    _useCharacterSuggestions = notifier.useCharacterSuggestions;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      appBar: AppBar(title: Text(appLocalizations.suggestionSettings)),
      body: Consumer<SqlSuggestionsNotifier>(
        builder: (context, notifier, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SqlSuggestionSettingsTitleOptionWidget(
                  title: appLocalizations.suggestionModes,
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsCardWidget(
                  title: appLocalizations.basicSuggestions,
                  subtitle: appLocalizations.basicSuggestionsDescription,
                  active: _useBasicSuggestions,
                  onChanged: (value) {
                    setState(() {
                      _useBasicSuggestions = value;
                      if (value) _useAdvancedSuggestions = false;
                    });
                  },
                  onConfigure: _useBasicSuggestions
                      ? () => AppRoutes.goToSqlBasicSettings(context)
                      : null,
                ),
                const SizedBox(height: 20.0),
                SqlSuggestionSettingsCardWidget(
                  title: appLocalizations.advancedSuggestions,
                  subtitle: appLocalizations.advancedSuggestionsDescription,
                  active: _useAdvancedSuggestions,
                  onChanged: (value) {
                    setState(() {
                      _useAdvancedSuggestions = value;
                      if (value) _useBasicSuggestions = false;
                    });
                  },
                  onConfigure: _useAdvancedSuggestions
                      ? () => AppRoutes.goToSqlAdvancedSettings(context)
                      : null,
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsTitleOptionWidget(
                  title: appLocalizations.otherSuggestions,
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsCardWidget(
                  title: appLocalizations.characterSuggestions,
                  subtitle: appLocalizations.characterSuggestionsDescription,
                  active: _useCharacterSuggestions,
                  onChanged: (value) {
                    setState(() {
                      _useCharacterSuggestions = value;
                    });
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ValueListenableBuilder(
                    valueListenable: _hasChangesNotifier,
                    builder: (context, value, child) {
                      return LoadingButtonWidget(
                        onPressed: _hasChanges ? _onSave : null,
                        text: appLocalizations.saveSettings,
                        style: ButtonStyleType.black,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

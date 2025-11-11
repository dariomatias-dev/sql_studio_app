import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_card_widget.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_title_option_widget.dart';

import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
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

  void _openBasicConfig(BuildContext context) =>
      context.push(RouteNames.sqlBasicSuggestionSettings);

  void _openAdvancedConfig(BuildContext context) =>
      context.push(RouteNames.sqlAdvancedSuggestionSettings);

  bool get _hasChanges {
    final notifier = context.read<SqlSuggestionsNotifier>();

    return _useBasicSuggestions != notifier.useBasicSuggestions ||
        _useAdvancedSuggestions != notifier.useAdvancedSuggestions ||
        _useCharacterSuggestions != notifier.useCharacterSuggestions;
  }

  Future<void> _onSave() async {
    final notifier = context.read<SqlSuggestionsNotifier>();
    final advancedNotifier = context.read<SqlAdvancedSuggestionsNotifier>();

    final previousAdvancedEnabled = notifier.useAdvancedSuggestions;

    if (!previousAdvancedEnabled && _useAdvancedSuggestions) {
      if (advancedNotifier.suggestions.isEmpty) {
        await advancedNotifier.resetSuggestions();
      }
    }

    notifier.setBasicSuggestions(_useBasicSuggestions);
    notifier.setAdvancedSuggestions(_useAdvancedSuggestions);
    notifier.setCharacterSuggestions(_useCharacterSuggestions);

    await notifier.saveSettings();

    if (!mounted) return;

    _hasChangesNotifier.value = _hasChanges;

    SnackBarUtils.show(context, 'Settings saved successfully!');
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
    return ScaffoldWidget(
      appBar: AppBar(title: const Text('Suggestion Settings')),
      body: Consumer<SqlSuggestionsNotifier>(
        builder: (context, notifier, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SqlSuggestionSettingsTitleOptionWidget(
                  title: 'Suggestion Modes',
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsCardWidget(
                  title: 'Basic Suggestions',
                  subtitle:
                      'Displays full SQL examples like "SELECT * FROM". Ideal for quick queries.',
                  active: _useBasicSuggestions,
                  onChanged: (value) {
                    setState(() {
                      _useBasicSuggestions = value;
                      if (value) _useAdvancedSuggestions = false;
                    });
                  },
                  onConfigure: _useBasicSuggestions
                      ? () => _openBasicConfig(context)
                      : null,
                ),
                const SizedBox(height: 20.0),
                SqlSuggestionSettingsCardWidget(
                  title: 'Advanced Suggestions',
                  subtitle:
                      'Shows short hints like "ALL" or "COUNT" that expand into full SQL statements when clicked.',
                  active: _useAdvancedSuggestions,
                  onChanged: (value) {
                    setState(() {
                      _useAdvancedSuggestions = value;
                      if (value) _useBasicSuggestions = false;
                    });
                  },
                  onConfigure: _useAdvancedSuggestions
                      ? () => _openAdvancedConfig(context)
                      : null,
                ),
                const SizedBox(height: 12.0),
                const SqlSuggestionSettingsTitleOptionWidget(
                  title: 'Other Suggestions',
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsCardWidget(
                  title: 'Character Suggestions',
                  subtitle: 'Adds quick buttons to >, =, !, %, ; and more.',
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
                        text: 'Save Settings',
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

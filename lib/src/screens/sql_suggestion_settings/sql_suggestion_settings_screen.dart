import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_card_widget.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_title_option_widget.dart';
import 'package:sql_studio/src/shared/utils/snack_bar_utils.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class SqlSuggestionSettingsScreen extends StatefulWidget {
  const SqlSuggestionSettingsScreen({super.key});

  @override
  State<SqlSuggestionSettingsScreen> createState() =>
      _SqlSuggestionSettingsScreenState();
}

class _SqlSuggestionSettingsScreenState
    extends State<SqlSuggestionSettingsScreen> {
  void _openBasicConfig(BuildContext context) => context.push('/');

  void _openAdvancedConfig(BuildContext context) => context.push('/');

  Future<void> _onSave() async {
    await context.read<SqlSuggestionsNotifier>().saveSettings();

    if (!mounted) return;

    SnackBarUtils.show(context, 'Settings saved successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(title: const Text('Suggestion Settings')),
      body: Consumer<SqlSuggestionsNotifier>(
        builder: (context, notifier, _) {
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
                  active: notifier.useBasicSuggestions,
                  onChanged: notifier.setBasicSuggestions,
                ),
                if (notifier.useBasicSuggestions)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ButtonWidget(
                        onPressed: () => _openBasicConfig(context),
                        text: 'Configure',
                        style: ButtonStyleType.black,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 20.0),
                SqlSuggestionSettingsCardWidget(
                  title: 'Advanced Suggestions',
                  subtitle:
                      'Shows short hints like "ALL" or "COUNT" that expand into full SQL statements when clicked.',
                  active: notifier.useAdvancedSuggestions,
                  onChanged: notifier.setAdvancedSuggestions,
                ),
                if (notifier.useAdvancedSuggestions)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ButtonWidget(
                        onPressed: () => _openAdvancedConfig(context),
                        text: 'Configure',
                        style: ButtonStyleType.black,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 20.0),
                const SizedBox(height: 12.0),
                const SqlSuggestionSettingsTitleOptionWidget(
                  title: 'Other Suggestions',
                ),
                const SizedBox(height: 12.0),
                SqlSuggestionSettingsCardWidget(
                  title: 'Character Suggestions',
                  subtitle: 'Adds quick buttons to >, =, !, %, ; and more.',
                  active: notifier.useCharacterSuggestions,
                  onChanged: notifier.setCharacterSuggestions,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: LoadingButtonWidget(
                    onPressed: _onSave,
                    text: 'Save Settings',
                    style: ButtonStyleType.black,
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

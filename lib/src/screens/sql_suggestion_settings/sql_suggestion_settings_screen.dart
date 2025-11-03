import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_card_widget.dart';
import 'package:sql_studio/src/screens/sql_suggestion_settings/widgets/sql_suggestion_settings_title_option_widget.dart';

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
  bool useBasicSuggestions = true;
  bool useAdvancedSuggestions = false;
  bool useCharacterSuggestions = true;

  void _onBasicChanged(bool value) {
    setState(() {
      useBasicSuggestions = value;
      if (value) useAdvancedSuggestions = false;
    });
  }

  void _onAdvancedChanged(bool value) {
    setState(() {
      useAdvancedSuggestions = value;
      if (value) useBasicSuggestions = false;
    });
  }

  void _onCharacterChanged(bool value) {
    setState(() {
      useCharacterSuggestions = value;
    });
  }

  void _openBasicConfig() => context.push('/');
  void _openAdvancedConfig() => context.push('/');

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(title: const Text('Suggestion Settings')),
      body: Padding(
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
              active: useBasicSuggestions,
              onChanged: _onBasicChanged,
            ),
            if (useBasicSuggestions)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonWidget(
                    onPressed: _openBasicConfig,
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
              active: useAdvancedSuggestions,
              onChanged: _onAdvancedChanged,
            ),
            if (useAdvancedSuggestions)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonWidget(
                    onPressed: _openAdvancedConfig,
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
              active: useCharacterSuggestions,
              onChanged: _onCharacterChanged,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                text: 'Save Settings',
                onPressed: () {},
                style: ButtonStyleType.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

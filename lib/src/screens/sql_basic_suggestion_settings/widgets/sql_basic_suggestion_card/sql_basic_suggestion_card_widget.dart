import 'package:flutter/material.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/screens/sql_basic_suggestion_settings/widgets/sql_basic_suggestion_card/sql_basic_suggestion_card_controller.dart';

class SqlBasicSuggestionCardWidget extends StatefulWidget {
  const SqlBasicSuggestionCardWidget({super.key, required this.suggestion});

  final String suggestion;

  @override
  State<SqlBasicSuggestionCardWidget> createState() =>
      _SqlBasicSuggestionCardWidgetState();
}

class _SqlBasicSuggestionCardWidgetState
    extends State<SqlBasicSuggestionCardWidget> {
  late final _controller = SqlBasicSuggestionCardController(
    context: context,
    suggestion: widget.suggestion,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6.0,
        ),
        leading: const Icon(Icons.drag_handle, color: Colors.black54),
        title: Text(
          widget.suggestion.trim(),
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        trailing: IconButton(
          onPressed: _controller.showRemoveCommandDialog,
          tooltip: AppLocalizations.of(context)!.deleteSuggestion,
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
        ),
      ),
    );
  }
}

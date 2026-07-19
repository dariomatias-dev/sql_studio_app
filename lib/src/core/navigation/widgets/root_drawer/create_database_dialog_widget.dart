import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';

/// Dialog that lets the user create a new database by entering its label
/// and name.
class CreateDatabaseDialogWidget extends StatefulWidget {
  /// Creates the create-database dialog.
  const CreateDatabaseDialogWidget({super.key});

  /// Displays the create-database dialog on top of [context].
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return const CreateDatabaseDialogWidget();
      },
    );
  }

  @override
  State<CreateDatabaseDialogWidget> createState() =>
      _CreateDatabaseDialogWidgetState();
}

class _CreateDatabaseDialogWidgetState
    extends State<CreateDatabaseDialogWidget> {
  final formKey = GlobalKey<FormState>();

  final labelController = TextEditingController();
  final nameController = TextEditingController();

  bool _nameEdited = false;

  String _toSnakeCase(String input) {
    return input
        .trim()
        .replaceAll(RegExp('[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp('_+'), '_')
        .replaceAll(' ', '_')
        .toLowerCase();
  }

  Future<void> _onCreate() async {
    if (!formKey.currentState!.validate()) return;

    final label = labelController.text.trim();
    final name = nameController.text.trim();

    final getByNameResult = await context.read<DatabaseNotifier>().getByName(
      name,
    );

    var shouldStopFlow = false;

    await getByNameResult.fold(
      onSuccess: (value) async {
        if (value != null) {
          shouldStopFlow = true;

          final appLocalizations = AppLocalizations.of(context)!;

          await ErrorDialogWidget.show(
            context,
            description: appLocalizations.databaseAlreadyExists(name),
          );
        }
      },
      onFailure: (error) async {
        shouldStopFlow = true;

        await handleError(context, getByNameResult);
      },
    );

    if (shouldStopFlow) return;

    final createDatabase = DatabaseModel(label: label, name: name);

    if (!mounted) return;

    final result = await context.read<DatabaseNotifier>().create(
      createDatabase,
    );

    if (!mounted) return;

    if (result.isSuccess) {
      Navigator.pop(context);

      context.read<SqlCommandsNotifier>().activeDatabase = name;

      Navigator.pop(context);
    } else {
      await handleError(context, result);
    }
  }

  @override
  void dispose() {
    labelController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DialogWidget(
      title: appLocalizations.createDatabase,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputWidget(
              controller: labelController,
              labelText: appLocalizations.label,
              suffixIcon: IconButton(
                onPressed: () {
                  labelController.clear();
                  if (!_nameEdited) {
                    nameController.clear();
                  }

                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              ),
              onChanged: (value) {
                if (!_nameEdited) {
                  nameController.text = _toSnakeCase(value);
                }

                setState(() {});
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.pleaseEnterLabel;
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            InputWidget(
              controller: nameController,
              labelText: appLocalizations.name,
              suffixIcon: IconButton(
                onPressed: () {
                  nameController.clear();
                  _nameEdited = false;

                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              ),
              onChanged: (_) => _nameEdited = true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.pleaseEnterName;
                } else if (!RegExp(
                  r'^[a-z0-9_]+$',
                ).hasMatch(_toSnakeCase(value))) {
                  return appLocalizations.invalidCharactersDetected;
                }

                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        const CancelButtonWidget(),
        ButtonWidget(
          text: appLocalizations.create,
          onPressed: _onCreate,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

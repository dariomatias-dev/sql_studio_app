import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';
import 'package:sql_studio/src/shared/widgets/cancel_button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/error_dialog_widget.dart';

class CreateDatabaseDialogWidget extends StatefulWidget {
  const CreateDatabaseDialogWidget({super.key});

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
        .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
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

    await getByNameResult.fold(
      onSuccess: (value) async {
        if (value != null) {
          await showDialog(
            context: context,
            builder: (context) {
              return ErrorDialogWidget(
                description: 'Database "$name" already exists',
              );
            },
          );

          return;
        }
      },
      onFailure: (error) async {
        await handleError(context, getByNameResult);
      },
    );

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
    return DialogWidget(
      title: 'Create Database',
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputWidget(
              controller: labelController,
              labelText: 'Label',
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
                  return 'Please enter a label';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            InputWidget(
              controller: nameController,
              labelText: 'Name',
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
                  return 'Please enter a name';
                } else if (!RegExp(
                  r'^[a-z0-9_]+$',
                ).hasMatch(_toSnakeCase(value))) {
                  return 'Invalid characters detected';
                }

                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CancelButtonWidget(),
        ButtonWidget(
          text: 'Create',
          onPressed: _onCreate,
          style: ButtonStyleType.black,
        ),
      ],
    );
  }
}

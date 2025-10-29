import 'package:flutter/material.dart';

import 'package:sql_studio/src/core/result.dart';

import 'package:sql_studio/src/screens/main/widgets/create_database_dialog_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_database_group/drawer_database_group_widget.dart';

import 'package:sql_studio/src/services/database_service.dart';

import 'package:sql_studio/src/shared/models/database_model.dart';
import 'package:sql_studio/src/shared/widgets/input_widget.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _searchController = TextEditingController();
  final _databaseService = DatabaseService();

  final _databases = <DatabaseModel>[];
  String _filter = '';
  bool _isLoading = true;

  Future<void> _loadDatabases() async {
    setState(() {
      _isLoading = true;
    });

    final databases = await _databaseService.getAll();

    if (databases is SuccessResult<List<DatabaseModel>>) {
      setState(() {
        _databases
          ..clear()
          ..addAll(databases.value);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showCreateDatabaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDatabaseDialogWidget(
          onCreated: (database) async {
            await _databaseService.create(database);

            await _loadDatabases();
          },
        );
      },
    );
  }

  Future<void> _toggleFavorite(DatabaseModel database) async {
    await _databaseService.toggleFavorite(database);

    await _loadDatabases();
  }

  Future<void> _deleteDatabase(DatabaseModel database) async {
    await _databaseService.delete(database);

    await _loadDatabases();
  }

  @override
  void initState() {
    super.initState();

    _loadDatabases();
  }

  @override
  Widget build(BuildContext context) {
    final lowerFilter = _filter.toLowerCase();

    final favorites = <DatabaseModel>[];
    final allDatabases = <DatabaseModel>[];

    for (final db in _databases) {
      if (db.name.toLowerCase().contains(lowerFilter)) {
        (db.isFavorite ? favorites : allDatabases).add(db);
      }
    }

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputWidget(
                hintText: 'Search databases',
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _filter = value);
                },
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          DatabaseGroupWidget(
                            title: 'Favorites',
                            databases: favorites,
                            toggleFavorite: _toggleFavorite,
                            onDelete: _deleteDatabase,
                          ),
                          const SizedBox(height: 20.0),
                          DatabaseGroupWidget(
                            title: 'All Databases',
                            databases: allDatabases,
                            toggleFavorite: _toggleFavorite,
                            onDelete: _deleteDatabase,
                          ),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
              child: ButtonWidget(
                onPressed: _showCreateDatabaseDialog,
                text: 'Create New Database',
                backgroundColor: Colors.grey.shade100,
                borderColor: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

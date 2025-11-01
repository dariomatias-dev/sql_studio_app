import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sql_studio/src/core/routes/route_names.dart';

import 'package:sql_studio/src/screens/main/widgets/theme_switcher_button_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: Scaffold.of(context).openDrawer,
            tooltip: 'Show Menu',
            icon: const Icon(Icons.menu, color: Colors.black),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            context.push(RouteNames.databasePath);
          },
          tooltip: 'Open Fullscreen',
          icon: const Icon(Icons.open_in_full, color: Colors.black),
        ),
        const ThemeSwitcherButtonWidget(),
      ],
    );
  }
}

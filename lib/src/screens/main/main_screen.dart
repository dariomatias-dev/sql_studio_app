import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/routes/app_routes.dart';

import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';

import 'package:sql_studio/src/screens/main/widgets/drawer/drawer_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/main_screen_nav_buttons_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/main_screen_screens_widget.dart';
import 'package:sql_studio/src/screens/main/widgets/main_screen_swipe_wrapper_widget.dart';

import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<MainScreenNotifier>();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: ScaffoldWidget(
        showExitButton: false,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                AppRoutes.goToDatabase(context);
              },
              tooltip: AppLocalizations.of(context)!.openFullscreen,
              icon: const Icon(Icons.open_in_full, color: Colors.black),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: MainScreenSwipeWrapper(
          notifier: notifier,
          pageController: _pageController,
          child: MainScreenScreensWidget(
            notifier: notifier,
            pageController: _pageController,
          ),
        ),
        bottomNavigationBar: MainScreenSwipeWrapper(
          notifier: notifier,
          pageController: _pageController,
          child: MainScreenNavButtonsWidget(
            notifier: notifier,
            pageController: _pageController,
          ),
        ),
      ),
    );
  }
}

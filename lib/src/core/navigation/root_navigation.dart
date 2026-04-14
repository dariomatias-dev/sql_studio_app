import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/navigation/widgets/root_drawer/drawer_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_nav_bar_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_swipe_wrapper_widget.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

import 'package:sql_studio/src/screens/databases/databases_screen.dart';
import 'package:sql_studio/src/screens/home/home_screen.dart';
import 'package:sql_studio/src/screens/settings/settings_screen.dart';

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  final _pageController = PageController();

  List<Widget> get _screens => const <Widget>[
    HomeScreen(),
    DatabasesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<NavigationNotifier>();

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(),
        drawer: const RootDrawerWidget(),
        body: RootSwipeWrapperWidget(
          notifier: notifier,
          pageController: _pageController,
          child: PageView(
            controller: _pageController,
            onPageChanged: notifier.setIndex,
            children: _screens,
          ),
        ),
        bottomNavigationBar: RootSwipeWrapperWidget(
          notifier: notifier,
          pageController: _pageController,
          child: RootNavBarWidget(
            notifier: notifier,
            pageController: _pageController,
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/drawer_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_nav_bar_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_swipe_wrapper_widget.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/core/views/home/home_screen.dart';
import 'package:sql_studio/src/core/views/settings/settings_screen.dart';
import 'package:sql_studio/src/features/database/presentation/views/databases_screen.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';

/// Root scaffold hosting the app's drawer, swipeable pages, and bottom
/// navigation bar.
class RootNavigation extends ConsumerStatefulWidget {
  /// Creates the root navigation scaffold.
  const RootNavigation({super.key});

  @override
  ConsumerState<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends ConsumerState<RootNavigation> {
  late final PageController _pageController;
  late final ProviderSubscription<int> _indexSubscription;
  late final FocusNode _editorFocusNode;

  bool _isEditorFocused = false;
  bool _wasKeyboardOpen = false;

  void _onEditorFocusChanged() {
    setState(() => _isEditorFocused = _editorFocusNode.hasFocus);
  }

  List<Widget> _screens(double bottomInset) => <Widget>[
    HomeScreen(navBarInset: bottomInset),
    _withBottomInset(bottomInset, const DatabasesScreen()),
    _withBottomInset(bottomInset, const SettingsScreen()),
  ];

  /// Patches the ancestor [MediaQuery] bottom padding so screens with
  /// scrollable content (via their [SafeArea]) inset around the floating
  /// nav bar instead of being covered by it.
  Widget _withBottomInset(double bottomInset, Widget child) {
    return Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);

        return MediaQuery(
          data: mediaQuery.copyWith(
            padding: mediaQuery.padding.copyWith(bottom: bottomInset),
          ),
          child: child,
        );
      },
    );
  }

  void _onIndexChanged(int? previous, int page) {
    if (!_pageController.hasClients) return;

    if (_pageController.page?.round() == page) return;

    unawaited(
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _indexSubscription = ref.listenManual(
      navigationViewModelProvider,
      _onIndexChanged,
    );

    _editorFocusNode = ref.read(sqlEditorViewModelProvider.notifier).focusNode
      ..addListener(_onEditorFocusChanged);
  }

  @override
  void dispose() {
    _indexSubscription.close();
    _pageController.dispose();
    _editorFocusNode.removeListener(_onEditorFocusChanged);

    super.dispose();
  }

  static const double _navBarHeight = 68;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(navigationViewModelProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.black, size: 22),
          shape: const Border(
            bottom: BorderSide(color: AppColors.background),
          ),
        ),
        onDrawerChanged: (isOpened) {
          if (isOpened) _editorFocusNode.unfocus();
        },
        drawer: const RootDrawerWidget(),
        body: Builder(
          builder: (bodyContext) {
            final isKeyboardOpen =
                MediaQuery.viewInsetsOf(bodyContext).bottom > 0;

            if (_wasKeyboardOpen && !isKeyboardOpen && _isEditorFocused) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _editorFocusNode.unfocus(),
              );
            }
            _wasKeyboardOpen = isKeyboardOpen;

            final hideNavBar = _isEditorFocused && isKeyboardOpen;
            final bottomInset = hideNavBar
                ? 0.0
                : _navBarHeight + MediaQuery.of(bodyContext).padding.bottom;

            return Stack(
              children: <Widget>[
                RootSwipeWrapperWidget(
                  pageController: _pageController,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) => notifier.index = page,
                    children: _screens(bottomInset),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    ignoring: hideNavBar,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      offset: hideNavBar ? const Offset(0, 1) : Offset.zero,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        opacity: hideNavBar ? 0 : 1,
                        child: RootSwipeWrapperWidget(
                          pageController: _pageController,
                          child: RootNavBarWidget(
                            pageController: _pageController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

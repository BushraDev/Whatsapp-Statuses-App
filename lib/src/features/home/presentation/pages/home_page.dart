import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:statusesapp/src/features/categories/presentation/pages/categories_page.dart';
import 'package:statusesapp/src/features/favorites/presentation/pages/favorites_page.dart';
import 'package:statusesapp/src/features/home/presentation/providers/app_bar_provider.dart';
import 'package:statusesapp/src/features/settings/presentation/pages/settings_page.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/widgets/custom_app_bar.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: watch(appBarNotifierProvider).title,
        ),
        body: PersistentTabView(
          context,
          onItemSelected: (int index) {
            onItemSelected(context, index);
          },
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarItems(context),
          confineInSafeArea: true,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears.
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style3, // Choose the nav bar style with this property.
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [CategoriesPage(), FavoritesPage(), SettingsPage()];
  }

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext context) {
    return [
      _buildNavBarItem(
        context: context,
        icon: Icon(Icons.home),
        title: (AppMessages.home),
      ),
      _buildNavBarItem(
        context: context,
        icon: Icon(Icons.favorite),
        title: (AppMessages.favorites),
      ),
      _buildNavBarItem(
        context: context,
        icon: Icon(Icons.settings),
        title: (AppMessages.settings),
      ),
    ];
  }

  PersistentBottomNavBarItem _buildNavBarItem(
      {BuildContext context, Widget icon, String title}) {
    return PersistentBottomNavBarItem(
      icon: icon,
      title: title,
      activeColorPrimary: Theme.of(context).primaryColor,
      inactiveColorPrimary: Theme.of(context).iconTheme.color,
    );
  }

  onItemSelected(BuildContext context, int index) {
    String title = index == 0
        ? AppMessages.home
        : index == 1
            ? AppMessages.favorites
            : AppMessages.settings;
    print("this is onBottomNavBarItemPressed function");
    print("this is title $title");
    print(
        "this is title from provider before change ${context.read(appBarNotifierProvider).title}");
    context.read(appBarNotifierProvider).changeTitle(title);
    print(
        "this is title from provider after change ${context.read(appBarNotifierProvider).title}");
  }
}

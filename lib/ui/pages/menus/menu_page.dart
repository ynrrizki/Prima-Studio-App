import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:prima_studio/ui/pages/menus/home/home_page.dart';
import 'package:prima_studio/ui/pages/menus/profile/profile_page.dart';
import 'package:prima_studio/ui/pages/menus/search/search_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const HomePage(),
        const SearchPage(),
        const ProfilePage(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "Home",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.search),
          title: "Search",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: "Profile",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      screens: buildScreens(),
      items: navBarsItems(),
      bottomScreenMargin: 0,
      confineInSafeArea: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(25),
        colorBehindNavBar: Colors.transparent,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(64, 92, 91, 91),
            blurRadius: 25,
            offset: Offset(0, 2),
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle: NavBarStyle.style12,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const NavBarPadding.symmetric(vertical: 9),
      hideNavigationBar: false,
    );
  }
}

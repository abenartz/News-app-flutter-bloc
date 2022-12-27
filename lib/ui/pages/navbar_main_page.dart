import 'package:dispatcher/ui/pages/favorites/favorites_page.dart';
import 'package:dispatcher/ui/pages/home/home_page.dart';
import 'package:dispatcher/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/navbar_main/navbar_main_bloc.dart';
import '../../constants/app_colors.dart';
import '../../enums/nav_bar_item.dart';

class NavbarMainPage extends StatelessWidget {

  final navbarPages = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage()
  ];

  final List<NavigationDestination> _navDestinations = List.empty(growable: true);

  NavbarMainPage({super.key}) {
    initNavDestinations();
  }

  void initNavDestinations() {
    for (var item in NavbarItem.values) {
      _navDestinations.add(
          NavigationDestination(
              icon: Icon(
                item.icon,
                color: AppColors.iconColor,
              ),
              label: item.title
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<NavbarMainBloc, NavbarMainState>(
        builder: (context, state) {
          final pageIndex =
              state.item.index < navbarPages.length ? state.item.index : 0;
          return navbarPages[pageIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavbarMainBloc, NavbarMainState>(
        builder: (context, state) {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: AppColors.appBackground,
              indicatorColor: Colors.amber[800],
            ),
            child: NavigationBar(
              height: 64,
              destinations: _navDestinations,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: state.item.index,
              onDestinationSelected: (index) => context
                  .read<NavbarMainBloc>()
                  .add(NavbarItemPressed(NavbarItem.values.elementAt(index))),
            ),
          );
        },
      ),
    );
  }

}

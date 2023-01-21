import 'dart:developer';

import 'package:dispatcher/bloc/home/home_bloc.dart';
import 'package:dispatcher/repository/articles_repository.dart';
import 'package:dispatcher/ui/pages/favorites/favorites_page.dart';
import 'package:dispatcher/ui/pages/home/home_page.dart';
import 'package:dispatcher/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navbar_main/navbar_main_bloc.dart';
import '../../constants/app_colors.dart';
import '../../enums/nav_bar_item.dart';

class NavbarMainPage extends StatelessWidget {

  final PageController _pageController = PageController();

  final _navbarPages = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage()
  ];

  final List<NavigationDestination> _navDestinations = [
    NavigationDestination(
        icon: Icon(NavbarItem.home.icon, color: AppColors.iconColor),
        label: NavbarItem.home.title
    ),
    NavigationDestination(
        icon: Icon(NavbarItem.favorites.icon, color: AppColors.iconColor),
        label: NavbarItem.favorites.title
    ),
    NavigationDestination(
        icon: Icon(NavbarItem.profile.icon, color: AppColors.iconColor),
        label: NavbarItem.profile.title
    ),
  ];

  NavbarMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarMainBloc(),
        ),
        BlocProvider(
          create: (context) =>
              HomeBloc(
                  articleRepository: context.read<ArticlesRepository>()
              ),
        ),
      ],
      child: _navBarMainView(),
    );
  }

  Scaffold _navBarMainView() {
    return Scaffold(
      body: BlocListener<NavbarMainBloc, NavbarMainState>(
        listener: (context, state) {
          _pageController.jumpToPage(state.item.index);
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _navbarPages,
        ),
      ),
      bottomNavigationBar: _bottomNavigationBarView(),
    );
  }

  Widget _bottomNavigationBarView() {
    return BlocBuilder<NavbarMainBloc, NavbarMainState>(
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
              onDestinationSelected: (index) =>
                  context.read<NavbarMainBloc>().add(
                      NavbarItemPressed(NavbarItem.values.elementAt(index))),
            ),
          );
        },
      );
  }

  void _onPageChanged(int value) {
    log("_onPageChanged: page $value");
  }

}

import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../enums/nav_bar_item.dart';
import '../../widgets/main_app_bar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: MainAppBar(
      title: NavbarItem.favorites.title,
      bgColor: AppColors.appBackground
    ),
    body: Center(
        child: Text(
          NavbarItem.favorites.title,
          style: const TextStyle(fontSize: 72),
        )),
  );

}
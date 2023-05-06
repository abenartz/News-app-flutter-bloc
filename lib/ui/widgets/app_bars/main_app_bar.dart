import 'package:dispatcher/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MainAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: Constants.appBarElevation,
      title: Row(
        children: [
          SizedBox(
            height: 31,
            width: 31,
            child:  Image.asset("images/LOGO.png"),
          ),
          Text(title),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          color: AppColors.iconColor,
          onPressed: () => {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          color: AppColors.iconColor,
          onPressed: () => {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Constants.appBarHeight);

}
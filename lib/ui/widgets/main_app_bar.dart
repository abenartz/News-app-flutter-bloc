import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MainAppBar({
    super.key,
    required this.title,
    required this.bgColor
  });

  final String title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 6,
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
  Size get preferredSize => const Size.fromHeight(64);

}
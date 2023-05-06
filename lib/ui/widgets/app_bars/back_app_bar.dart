import 'package:dispatcher/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {

  const BackAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: Constants.appBarElevation,
      title: const Text(
        'Back',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400
      ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Constants.appBarHeight);

}
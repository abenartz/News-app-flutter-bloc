import 'package:flutter/material.dart';
import '../../../enums/nav_bar_item.dart';
import '../../widgets/app_bars/main_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: MainAppBar(
      title: NavbarItem.profile.title
    ),
    body: Center(
        child: Text(
          NavbarItem.profile.title,
          style: const TextStyle(fontSize: 72),
        )),
  );

}
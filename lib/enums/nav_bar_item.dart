import 'package:flutter/material.dart';

enum NavbarItem {
  home('Home', Colors.greenAccent, Icons.home),
  favorites('Favorites', Colors.pinkAccent, Icons.star_border),
  profile('Profile', Colors.indigoAccent, Icons.account_circle);

  const NavbarItem(this.title, this.color, this.icon);

  final String title;
  final Color color;
  final IconData icon;
}
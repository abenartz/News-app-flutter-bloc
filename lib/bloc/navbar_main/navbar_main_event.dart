part of 'navbar_main_bloc.dart';

@immutable
abstract class NavbarMainEvent {
  const NavbarMainEvent();
}

class NavbarItemPressed extends NavbarMainEvent {
  const NavbarItemPressed(this.tappedItem);
  final NavbarItem tappedItem;
}

part of 'navbar_main_bloc.dart';


@immutable
class NavbarMainState extends Equatable {
  final NavbarItem item;
  const NavbarMainState(this.item);

  @override
  List<Object?> get props => [item];
}


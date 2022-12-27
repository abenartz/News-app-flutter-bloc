part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchArticles extends HomeEvent {

  FetchArticles({this.searchKey = ""});

  final String? searchKey;
}

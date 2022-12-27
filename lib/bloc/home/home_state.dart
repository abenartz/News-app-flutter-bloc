part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArticlesLoaded extends HomeState {
  ArticlesLoaded({required this.articles});

  final List<Article> articles;

  @override
  List<Object?> get props => [articles];
}

class Loading extends HomeState {

  @override
  List<Object?> get props => [];
}

class Error extends HomeState {
  Error({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
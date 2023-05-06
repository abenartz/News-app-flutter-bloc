import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dispatcher/repository/articles_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../model/article.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  static const pageSize = 20;
  final ArticlesRepository articleRepository;
  int _pageNum = 1;
  bool _isSearchExhausted = false;
  bool _isFetching = false;
  final List<Article> _articles = [];

  HomeBloc({required this.articleRepository}) : super(HomeInitial()) {
    log("HomeBloc init..");
    on<FetchArticles>(_onFetchArticles);
  }

  _onFetchArticles(FetchArticles event, Emitter<HomeState> emit) async {
    if (!_isSearchExhausted && !_isFetching) {
      _isFetching = true;
      emit(_pageNum <= 1
          ? Loading()
          : ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: true));
      final articlesToAdd = await articleRepository.getPageTopHeadlines(_pageNum, event.searchKey);
      for (var article in articlesToAdd) {
        log("HomeBloc article to add- ${article.title}");
      }
      if (articlesToAdd.length < pageSize) {
        _isSearchExhausted = true;
      }
      _articles.addAll(articlesToAdd);
      emit(ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: false));
      _pageNum++;
      _isFetching = false;
    }
  }
}

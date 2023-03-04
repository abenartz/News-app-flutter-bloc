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

  final ArticlesRepository articleRepository;
  int _pageNum = 0;
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
      emit(_pageNum == 0
          ? Loading()
          : ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: true));
      final articlesToAdd = await articleRepository.getPageTopHeadlines(_pageNum, event.searchKey);
      if (articlesToAdd.isEmpty) {
        _isSearchExhausted = true;
      }
      _articles.addAll(articlesToAdd);
      emit(ArticlesLoaded(articles: _articles, query: event.searchKey, isFetchingMore: false));
      _pageNum++;
      _isFetching = false;
    }
  }
}

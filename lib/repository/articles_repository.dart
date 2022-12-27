
import 'package:dio/dio.dart';
import 'package:dispatcher/api/articles/responses/get_everything_response.dart';
import 'package:dispatcher/model/article.dart';

import '../api/articles/articles_api.dart';
import '../network/dio_exceptions.dart';

class ArticlesRepository {

  final ArticlesApi articlesApi = ArticlesApi();

  ArticlesRepository();

  Future<List<Article>> getEveryArticles() async {
    try {
      final GetEverythingResponse response = await articlesApi.getEverything();
      return response.articles.map((articleDto) =>
          Article.fromDto(articleDto)
      ).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Article>> getTopHeadlines() async {
    try {
      final GetEverythingResponse response = await articlesApi.getTopHeadlines();
      return response.articles.map((articleDto) =>
          Article.fromDto(articleDto)
      ).toList();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}
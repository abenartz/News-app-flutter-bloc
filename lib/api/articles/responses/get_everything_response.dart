import '../dto/article_dto.dart';

class GetEverythingResponse {
  final String? status;
  final int? totalResults;
  final List<ArticleDto> articles;

  GetEverythingResponse({this.status, this.totalResults, required this.articles});

  factory GetEverythingResponse.fromJson(Map<String, dynamic> json) {
    var articlesResult = <ArticleDto>[];
    if (json['articles'] != null) {
      json['articles'].forEach((v) {
        articlesResult.add(ArticleDto.fromJson(v));
      });
    }
    return GetEverythingResponse(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: articlesResult
    );
  }
}




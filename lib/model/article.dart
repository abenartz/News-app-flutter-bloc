import 'package:dispatcher/api/articles/dto/article_dto.dart';
import 'package:intl/intl.dart';

class Article {

  const Article({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.publishedAt,
    this.isFavorite = false
  });

  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final DateTime publishedAt;
  final bool isFavorite;

  factory Article.fromDto(ArticleDto dto) {
    return Article(
      imageUrl: dto.urlToImage ?? '',
      title: dto.title ?? '',
      author: dto.author ?? 'Unknown author',
      description: dto.description ?? '',
      publishedAt: DateFormat('yyyy-mm-dd').parse(dto.publishedAt ?? '')
    );
  }
}
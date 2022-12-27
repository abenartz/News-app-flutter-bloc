import 'package:dispatcher/api/articles/dto/article_dto.dart';

class Article {

  const Article({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.description,
    this.isFavorite = false
  });

  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final bool isFavorite;

  factory Article.fromDto(ArticleDto dto) {
    return Article(
      imageUrl: dto.urlToImage ?? '',
      title: dto.title ?? '',
      author: dto.author ?? '',
      description: dto.description ??''
    );
  }
}
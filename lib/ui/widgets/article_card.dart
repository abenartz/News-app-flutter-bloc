
import 'package:flutter/material.dart';

import '../../model/article.dart';

class ArticleCard extends StatelessWidget {
  static const cardRadius = 20.0;
  static const separateHeight = 12.0;
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius)),
      child: Column(
        children: [
          _articleImageView(),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.publishedAt.toString(),
                    style: _textStyleDateAndAuthor()),
                const SizedBox(height: separateHeight),
                Text(article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: separateHeight),
                Text(article.author, style: _textStyleDateAndAuthor()),
                const SizedBox(height: separateHeight),
                Text(article.description,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ClipRRect _articleImageView() {
    return ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(cardRadius),
              topRight: Radius.circular(cardRadius)),
          child: Image.network(
            article.imageUrl,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.asset(
                'images/no_image.jpeg',
                height: 150,
                width: double.infinity,
              );
            },
            height: 150,
            width: double.infinity,
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        );
  }

  TextStyle _textStyleDateAndAuthor() {
    return TextStyle(
        color: const Color(0xff5A5A89).withOpacity(0.7),
        fontSize: 14,
        fontWeight: FontWeight.w400);
  }
}

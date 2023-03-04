import 'package:flutter/material.dart';

import '../../model/article.dart';

class FavoriteArticleCard extends StatelessWidget {
  static const cardRadius = 5.0;
  static const imageHeight = 100.0;
  final Article article;

  const FavoriteArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius)),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _articleImageView(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    _chipList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _articleImageView() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(cardRadius)),
      child: Image.network(
        article.imageUrl,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            'images/no_image.jpeg',
            height: imageHeight,
            width: imageHeight,
          );
        },
        height: imageHeight,
        width: imageHeight,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            height: imageHeight,
            width: imageHeight,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  _chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        _buildChip('Crypto'),
        _buildChip('+3'),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF5A5A89),
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
      ),
      backgroundColor: const Color(0XFFD9DBE9),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

}

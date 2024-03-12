import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends AritlcesEntity {
  const Article(
      {String? id,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

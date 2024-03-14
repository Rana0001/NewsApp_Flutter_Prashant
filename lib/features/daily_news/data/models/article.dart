import 'package:newsapp/features/daily_news/domain/entities/articles.dart';

class Article extends ArticleEntity {
  Article(
      {int? id,
      String? author,
      String? source,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content})
      : super(
            id: id!,
            author: author!,
            source: source!,
            title: title!,
            description: description!,
            url: url!,
            urlToImage: urlToImage!,
            publishedAt: publishedAt!,
            content: content!);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int? ?? 1,
      author: json['author'] as String? ?? "",
      source: json['source']['name'] as String? ?? "",
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      url: json['url'] as String? ?? "",
      urlToImage: json['urlToImage'] as String? ?? "",
      publishedAt: json['publishedAt'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'source': source,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? author;
  final String? source;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity({
    this.id,
    this.author,
    this.source,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        source,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];

  factory ArticleEntity.fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      author: json['author'] as String? ?? "",
      source: json['source'] as String? ?? "",
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      url: json['url'] as String? ?? "",
      urlToImage: json['urlToImage'] as String? ?? "",
      publishedAt: json['publishedAt'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );
  }

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

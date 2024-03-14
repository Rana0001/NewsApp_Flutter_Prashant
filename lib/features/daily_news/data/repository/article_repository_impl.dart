import 'dart:io';


import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiServices? newsApiServices;
  ArticleRepositoryImpl({this.newsApiServices});

  @override
  Future<List<ArticleEntity>> getNewsArticles(
      {String? country, String? category}) async {
    return await newsApiServices!
        .getNewsArticles(country: country, category: category);
  }
}

import 'package:newsapp/features/daily_news/domain/entities/articles.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> getNewsArticles(
      {String? country, String? category});
}

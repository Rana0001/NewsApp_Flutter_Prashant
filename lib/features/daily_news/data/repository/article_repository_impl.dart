import 'package:newsapp/core/resources/data_state.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<DataState<List<Article>>> getArticles() async {
    return const DataSuccess(data: []);
  }
}

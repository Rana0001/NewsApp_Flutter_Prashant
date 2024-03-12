import 'package:newsapp/core/resources/data_state.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';

abstract class ArticleRepository {
  Future<DataState<List<AritlcesEntity>>> getArticles();
}

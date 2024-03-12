import 'package:newsapp/core/resources/data_state.dart';
import 'package:newsapp/core/usecases/usecases.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UserCase<DataState<List<AritlcesEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);
  @override
  Future<DataState<List<AritlcesEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}

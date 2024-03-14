part of 'article_bloc.dart';

class ArticleState extends Equatable {
  const ArticleState({this.articles = const <ArticleEntity>[]});
  final List<ArticleEntity> articles;

  @override
  List<Object> get props => [articles];

  copyWith({List<ArticleEntity>? articles}) {
    return ArticleState(articles: articles ?? this.articles);
  }
}

final class ArticleLoading extends ArticleState {
  const ArticleLoading();
}

final class ArticleSuccess extends ArticleState {
  @override
  final List<ArticleEntity> articles;

  const ArticleSuccess({required this.articles});
}

final class ArticleError extends ArticleState {}

final class ArticleRemovedFromFavorites extends ArticleState {
  const ArticleRemovedFromFavorites();
}

class ArticleSearchState extends ArticleState {
  const ArticleSearchState({this.articles = const <ArticleEntity>[]});
  @override
  final List<ArticleEntity> articles;
}

part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

final class GetNewsArticles extends ArticleEvent {
  final String? country;
  final String? category;

  const GetNewsArticles({this.country, this.category});
}

class AddToFavorites extends ArticleEvent {
  final ArticleEntity articleEntity;

  const AddToFavorites({required this.articleEntity});
}

class RemoveFromFavorites extends ArticleEvent {
  final ArticleEntity articleEntity;

  const RemoveFromFavorites({required this.articleEntity});
}

class GetFavorites extends ArticleEvent {
  const GetFavorites();
}

class SearchNewsArticles extends ArticleEvent {
  final String? query;

  const SearchNewsArticles({this.query});
}

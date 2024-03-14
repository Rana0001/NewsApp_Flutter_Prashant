import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  NewsApiServices? newsApiServices;
  ArticleBloc({this.newsApiServices}) : super(const ArticleLoading()) {
    on<GetNewsArticles>(_onGetArticles);
    on<AddToFavorites>(onAddToFavorites);
    on<RemoveFromFavorites>(onRemoveFromFavorites);
    on<GetFavorites>(onGetFavorites);
  }

  void _onGetArticles(
    GetNewsArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      final List<ArticleEntity> articles = await newsApiServices!
          .getNewsArticles(category: event.category, country: event.country);
      print(articles.length);
      emit(ArticleSuccess(articles: articles));
    } catch (e) {
      print(e.toString());
      emit(ArticleError());
    }
  }

  void onAddToFavorites(
    AddToFavorites event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      bool value = await newsApiServices!.addToFavourite(event.articleEntity);
      if (value) {
        emit(const ArticleSuccess(articles: []));
      } else {
        emit(ArticleError());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      bool value =
          await newsApiServices!.removeFromFavourite(event.articleEntity);
      if (value) {
        emit(const ArticleRemovedFromFavorites());
      } else {
        emit(ArticleError());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void onGetFavorites(
    GetFavorites event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      final List<ArticleEntity> articles =
          await newsApiServices!.getFavouriteArticles();
      emit(ArticleSuccess(articles: articles));
    } catch (e) {
      print(e.toString());
      emit(ArticleError());
    }
  }

  void onSearchNewsArticles(
    SearchNewsArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(const ArticleLoading());
    try {
      final List<ArticleEntity> articles = await newsApiServices!
          .getNewsArticles(category: "business", country: "us");
      emit(ArticleSearchState(articles: articles));

    } catch (e) {
      print(e.toString());
      emit(ArticleError());
    }
  }
}

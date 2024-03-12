import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newsapp/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:newsapp/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:newsapp/features/daily_news/domain/repository/article_repository.dart';
import 'package:newsapp/features/daily_news/domain/usecases/get_articles.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<NewsApiServices>(NewsApiServices(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // UseCase
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
}

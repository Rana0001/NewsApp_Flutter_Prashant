import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/core/resources/data_state.dart';
import 'package:newsapp/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiServices _newsApiServices;
  ArticleRepositoryImpl(this._newsApiServices);

  @override
  Future<DataState<List<Article>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiServices.getNewsArticles(
        country: country,
        category: category,
        apiKey: apiKey,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: httpResponse.data);
      } else {
        return DataError(
          error: DioException(
            response: httpResponse.response,
            error: httpResponse.response.statusMessage,
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(error: e);
    }
  }
}

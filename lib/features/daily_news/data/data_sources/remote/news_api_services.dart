import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'news_api_services.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class NewsApiServices {
  @GET('/top-headlines')
  Future<HttpResponse<List<Article>>> getNewsArticles({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('apiKey') String? apiKey,
  });
}


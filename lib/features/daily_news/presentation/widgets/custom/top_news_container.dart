import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';

class TopNewsArticle extends StatelessWidget {
  const TopNewsArticle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final articleBloc = context.watch<ArticleBloc>();
    if (articleBloc.state.articles.isEmpty) {
      return const CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(articleBloc
                    .state.articles[0].urlToImage! ??
                "https://www.usmagazine.com/wp-content/uploads/2019/07/Beyonce-Spirit-Video-Looks-1.jpg?w=1200&quality=86&strip=all"),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              print("error");
            },
          ),
        ),
        child: Stack(
          children: [
            Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      articleBloc.state.articles[0].title ??
                          'Beyoncé reveals the name of her upcoming country album',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AppGaps.hGap10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      articleBloc.state.articles[0].source!.isNotEmpty
                          ? Text(
                              'Source: ${articleBloc.state.articles[0].source!}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Source: CNN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

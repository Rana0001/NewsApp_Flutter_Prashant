import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/active_index_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class ArticleDetailsPage extends StatefulWidget {
  final ArticleEntity? articleEntity;
  final String? category;
  final String? country;
  bool? isPressed;
  ArticleDetailsPage({
    super.key,
    this.category = "General",
    this.country = "US",
    this.isPressed = false,
    this.articleEntity,
  });

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeChangeCubit>().state;
    final stateActiveIndex = context.watch<ActiveIndexCubit>().state;
    final articleState = context.read<ArticleBloc>();
    String? dateTime = DateFormat.yMMMMd().format(
      DateTime.parse(widget.articleEntity!.publishedAt!),
    );
    if (state.isDark == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return BlocListener<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleError) {
          flushBarMessage(
            "Something went wrong to favorites",
            "Error",
            Colors.red,
          ).show(context);
        } else if (state is ArticleLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ArticleSuccess) {
          flushBarMessage(
            "Added to favorites",
            "Success",
            Colors.green,
          ).show(context);
        } else if (state is ArticleRemovedFromFavorites) {
          flushBarMessage(
            "Article Removed to favorites",
            "Success",
            Colors.red,
          ).show(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color:
                state.isDark! ? Colors.black : AppColors.shadeLightThemeColor1,
          ),
          backgroundColor: !state.isDark!
              ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
              : AppColors.shadeLightThemeColor1,
          actions: [
            !widget.isPressed!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPressed = !widget.isPressed!;
                      });
                      articleState.add(
                          AddToFavorites(articleEntity: widget.articleEntity!));
                    },
                    icon: const Icon(
                      Icons.bookmark_outline_outlined,
                      color: Colors.teal,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isPressed = !widget.isPressed!;
                      });
                      articleState.add(
                        RemoveFromFavorites(
                            articleEntity: widget.articleEntity!),
                      );
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.teal,
                    ),
                  ),
          ],
        ),
        body: Container(
          color: state.isDark!
              ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
              : AppColors.shadeLightThemeColor1,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        AppImagePath.verifiedUser,
                        color: !state.isDark!
                            ? HexColor(AppColors.primaryActiveButtonColor)
                            : AppColors.primaryLightThemeColor,
                        height: 30,
                      ),
                    ),
                  ),
                  title: Text(widget.articleEntity!.author! ?? "John Doe",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(dateTime),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.articleEntity!.urlToImage ??
                              "https://www.usmagazine.com/wp-content/uploads/2019/07/Beyonce-Spirit-Video-Looks-1.jpg?w=1200&quality=86&strip=all",
                        ),
                        fit: BoxFit.cover,
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
                              Text(
                                widget.articleEntity!.title! ??
                                    "Beyoncé reveals the name of her upcoming country album",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              AppGaps.hGap10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Source: ${widget.articleEntity!.source!}',
                                    style: const TextStyle(
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
                ),
                AppGaps.hGap10,
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: state.isDark!
                                    ? HexColor(
                                        AppColors.primaryActiveButtonColor)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    " #${stateActiveIndex.category}" ??
                                        "#Category",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: !state.isDark!
                                  ? HexColor(AppColors.primaryActiveButtonColor)
                                  : AppColors.secondaryLightThemeColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "#${stateActiveIndex.country}" ?? "#Country",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                AppGaps.hGap10,
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "${widget.articleEntity!.description} ${widget.articleEntity!.content}" ??
                        "Beyoncé has revealed the name of her upcoming country album, which is set to be released on November 12. The singer, 40, announced the news on her website on Tuesday, July 20, sharing a photo of a field of flowers with the words “Beyoncé” and “Be Alive” written in the sky. “‘Be Alive’ is a powerful, anthemic song that will be featured in the upcoming film King Richard, which stars Will Smith as Richard Williams, the father of Venus and Serena Williams,” the post read. “The song is a celebration of the human spirit, a tribute to the resilience of humans throughout the ages, from the first slaves who worked the land, to the present-day heroes of the world’s most popular sport, tennis.”",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Flushbar<dynamic> flushBarMessage(
    String? message, String? title, Color? color) {
  return Flushbar(
    message: message,
    title: title,
    isDismissible: true,
    backgroundColor: color!,
    icon: const Icon(
      Icons.info_outline_rounded,
      color: Colors.white,
      size: 30,
    ),
    duration: const Duration(seconds: 3),
  );
}

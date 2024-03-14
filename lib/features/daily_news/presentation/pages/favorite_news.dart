import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/config/routes/app_routes.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_notification.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_tile_explore.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ArticleBloc>().add(const GetFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final stateTheme = context.watch<ThemeModeChangeCubit>().state;
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (context, state) {
        if (state is ArticleError) {
          const ErrorPage();
        } else if (state is ArticleLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ArticleRemovedFromFavorites) {
          flushBarMessage("Removed from favorites", "Favorite News",
                  AppColors.alertLightThemeColor)
              .show(context);
        }
      },
      builder: (context, state) {
        return Container(
          color: !stateTheme.isDark!
              ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
              : AppColors.shadeLightThemeColor1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: SizedBox(
                      child: Text("Favorite News",
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            color: stateTheme.isDark!
                                ? HexColor(
                                    AppColors.primaryDarkThemeBackgroundColor)
                                : AppColors.shadeLightThemeColor1,
                          )),
                    ),
                  ),
                ],
              ),
              AppGaps.hGap10,
              Expanded(
                  child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            return await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Are you sure?"),
                                    content: const Text(
                                        "Do you want to remove this item?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            context.read<ArticleBloc>().add(
                                                RemoveFromFavorites(
                                                    articleEntity:
                                                        state.articles[index]));
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text("No")),
                                    ],
                                  );
                                });
                          }
                          if (direction == DismissDirection.startToEnd) {
                            return false;
                          }

                          return null;
                        },
                        background: Container(
                          color: HexColor(AppColors.primaryDarkBackgroundColor),
                          alignment: Alignment.centerLeft,
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: SvgPicture.asset(
                                AppImagePath.deleteIcon,
                                color: Colors.white,
                              )),
                        ),
                        key: ValueKey<String>(index.toString()),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailsPage(
                                    articleEntity: state.articles[index],
                                    isPressed: true,
                                  ),
                                ),
                                (route) => true);
                          },
                          child: CustomTile(
                            articleEntity: state.articles[index],
                          ),
                        ));
                  },
                  itemCount: state.articles.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                ),
              ))
            ],
          ),
        );
      },
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
      Icons.error,
      color: Colors.white,
      size: 30,
    ),
    duration: const Duration(seconds: 3),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/config/routes/app_routes.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/category_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_body.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_navbar.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_tile_explore.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(const GetNewsArticles(
          country: "us",
          category: "general",
        ));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeChangeCubit>().state;
    if (state.isDark == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
        color: !state.isDark!
            ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
            : AppColors.shadeLightThemeColor1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 10,
                  ),
                  child: SizedBox(
                    child: Text(
                      "Explore",
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: !state.isDark! ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppGaps.hGap10,
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        onTap: () {
                          context.read<ArticleBloc>().add(GetNewsArticles(
                                country: "us",
                                category: categories[index],
                              ));
                        },
                        index: index,
                        title: categories[index],
                      );
                    }),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImagePath.lineChartIcon,
                    color: !state.isDark! ? Colors.white : Colors.black,
                    height: 25,
                    width: 25,
                  ),
                  AppGaps.wGap10,
                  Text(
                    'Trending on Moblin 🔥',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: state.isDark! ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              height: 200,
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ArticleError) {
                    return const ErrorPage();
                  } else if (state is ArticleSuccess &&
                      state.articles.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: state.articles.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetailsPage(
                                        articleEntity: state.articles[index],
                                      ),
                                    ),
                                    (route) => true);
                              },
                              child: CustomTileExplore(
                                  index: index, article: state.articles[index]),
                            );
                          }),
                    );
                  }
                  return const Center(
                    child: Text("No Data"),
                  );
                },
              ),
            ))
          ],
        ));
  }
}

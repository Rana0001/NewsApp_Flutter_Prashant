import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/config/routes/app_routes.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/active_index_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:newsapp/features/daily_news/presentation/pages/explore_page.dart';
import 'package:newsapp/features/daily_news/presentation/pages/favorite_news.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/appbar_widget.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/category_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_circle_category.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_navbar.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/top_news_container.dart';
import 'package:newsapp/features/user/presentation/bloc/user_bloc.dart';
import 'package:newsapp/features/user/presentation/pages/ProfilePage.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({super.key, this.onMenuTap});
  final VoidCallback? onMenuTap;
  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  int _selectedIndex = 0;

  final List<Widget> _bodyWidgetList = <Widget>[
    const HomeScreen(),
    const ExplorePage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _bodyWidgetList[_selectedIndex],
        bottomNavigationBar: CustomNavBar(
          index: _selectedIndex,
          onIndexValueChange: _onNavBarTap,
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(const GetNewsArticles(
          country: 'us',
          category: 'sports',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = context.watch<UserBloc>().state;
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
        builder: (context, state) {
      if (state.runtimeType == ThemeModeChangeState) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ArticleBloc>().add(const GetNewsArticles(
                  country: 'us',
                  category: 'sports',
                ));
          },
          strokeWidth: 3,
          color: !state.isDark!
              ? HexColor(AppColors.primaryActiveButtonColor)
              : AppColors.primaryLightThemeColor,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: SingleChildScrollView(
            child: Container(
              color: !state.isDark!
                  ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
                  : AppColors.shadeLightThemeColor1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discover',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: !state.isDark!
                                      ? Colors.white
                                      : Colors.black,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                )),
                            Wrap(
                              children: [
                                AppGaps.wGap10,
                                const CustomThemeMode(),
                                AppGaps.wGap10,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: userState.userModel.photoUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 20,
                                      backgroundImage: imageProvider,
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          index: index,
                          title: categories[index],
                        );
                      },
                    ),
                  ),
                  AppGaps.hGap15,
                  const TopNewsArticle(),
                  AppGaps.hGap10,
                  const CustomRow(leadingTitle: 'Explore'),
                  AppGaps.hGap10,
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return CustomCircleCategory(
                          index: index,
                          onTap: () {
                            context.read<ArticleBloc>().add(GetNewsArticles(
                                  country: countryLetter[index],
                                  category: 'sports',
                                ));
                          },
                        );
                      },
                    ),
                  ),
                  AppGaps.hGap15,
                  const CustomRow(leadingTitle: 'Most Popular'),
                  AppGaps.hGap10,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                        if (state is ArticleSuccess &&
                            state.articles.isNotEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.articles.length,
                            itemBuilder: (context, index) {
                              final article = state.articles[index];

                              return CustomTile(
                                  articleEntity: article,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ArticleDetailsPage(
                                        articleEntity: article,
                                      ),
                                    ));
                                  });
                            },
                          );
                        } else if (state is ArticleError) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ArticleLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return CircularProgressIndicator(
          color: !state.isDark!
              ? HexColor(AppColors.primaryActiveButtonColor)
              : AppColors.primaryLightThemeColor,
        );
      }
    });
  }
}

class CustomRow extends StatelessWidget {
  final String? leadingTitle;
  final String? trailingTitle;
  const CustomRow({
    super.key,
    this.leadingTitle,
    this.trailingTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
      builder: (context, state) {
        if (state.runtimeType == ThemeModeChangeState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  leadingTitle ?? 'Trending',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: !state.isDark! ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

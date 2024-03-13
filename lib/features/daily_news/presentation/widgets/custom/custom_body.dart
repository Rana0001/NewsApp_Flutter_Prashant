import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/category_tile.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_circle_category.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_navbar.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/top_news_container.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({super.key, this.onMenuTap});
  final VoidCallback? onMenuTap;
  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover',
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          const CustomNotification(),
          AppGaps.wGap10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: 'https://avatars.githubusercontent.com/u/55942632?v=4',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, progress) =>
                  const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CategoryTile();
                  },
                ),
              ),
              AppGaps.hGap15,
              const TopNewsArticle(),
              AppGaps.hGap10,
              const CustomRow(
                  leadingTitle: 'Explore', trailingTitle: 'See more'),
              AppGaps.hGap10,
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CustomCircleCategory();
                  },
                ),
              ),
              AppGaps.hGap15,
              const CustomRow(
                  leadingTitle: 'Most Popular', trailingTitle: 'See more'),
              AppGaps.hGap10,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    "https://www.usmagazine.com/wp-content/uploads/2019/07/Beyonce-Spirit-Video-Looks-1.jpg?w=1200&quality=86&strip=all"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          AppGaps.wGap10,
                          Expanded(
                            child: Wrap(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Michael Edwards makes Liverpool return to oversee post-Klopp eras',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    AppGaps.hGap5,
                                    Text(
                                      'Fabrizio Romano',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor(AppColors
                                            .secondaryInActiveButtonColor),
                                      ),
                                    ),
                                    AppGaps.hGap5,
                                    Text(
                                      '19 Jul 2021, 12:00 PM',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor(AppColors
                                            .secondaryInActiveButtonColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            leadingTitle ?? 'Trending',
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            trailingTitle ?? 'See more',
            style: TextStyle(
              fontSize: 12,
              color: HexColor(AppColors.primaryActiveButtonColor),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

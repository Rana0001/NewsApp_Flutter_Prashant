import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomTile extends StatefulWidget {
  ArticleEntity? articleEntity;
  VoidCallback? onTap;
  CustomTile({
    this.onTap,
    super.key,
    this.articleEntity,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  String? dateTime;
  @override
  void initState() {
    super.initState();
    // change the date format of the articleEntity.publishedAt
    dateTime = DateFormat.yMMMd().format(
      DateTime.parse(widget.articleEntity!.publishedAt!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeChangeCubit>().state;
    if (state.isDark == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    widget.articleEntity!.urlToImage ??
                        "https://www.usmagazine.com/wp-content/uploads/2019/07/Beyonce-Spirit-Video-Looks-1.jpg?w=1200&quality=86&strip=all",
                    errorListener: (p0) {
                      print("error-11");
                    },
                  ),
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
                      Text(
                        widget.articleEntity!.title! ?? "Title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: !state.isDark!
                              ? AppColors.shadeLightThemeColor1
                              : AppColors.darkLightThemeColor,
                        ),
                      ),
                      AppGaps.hGap5,
                      Text(
                        widget.articleEntity!.source! ?? "Author",
                        style: TextStyle(
                          fontSize: 12,
                          color: state.isDark!
                              ? AppColors.darkLightThemeColor
                              : AppColors.shadeLightThemeColor1,
                        ),
                      ),
                      AppGaps.hGap5,
                      Text(
                        dateTime ?? "Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: state.isDark!
                              ? AppColors.darkLightThemeColor
                              : AppColors.shadeLightThemeColor1,
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

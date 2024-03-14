import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/domain/entities/articles.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomTileExplore extends StatefulWidget {
  final ArticleEntity? article;
  final int? index;
  const CustomTileExplore({
    super.key,
    this.index,
    this.article,
  });

  @override
  State<CustomTileExplore> createState() => _CustomTileExploreState();
}

class _CustomTileExploreState extends State<CustomTileExplore> {
  String? dateTime;
  @override
  void initState() {
    super.initState();
    dateTime = DateFormat.yMMMMd().format(
      DateTime.parse(widget.article!.publishedAt!),
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
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 100,
            width: 60,
            child: Text(widget.index.toString(),
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: HexColor(AppColors.secondaryInActiveButtonColor),
                )),
          ),
          AppGaps.wGap10,
          Expanded(
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article!.title! ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: !state.isDark! ? Colors.white : Colors.black,
                      ),
                    ),
                    AppGaps.hGap5,
                    Text(
                      widget.article!.description! ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: !state.isDark! ? Colors.white : Colors.black,
                      ),
                    ),
                    AppGaps.hGap5,
                    Text(
                      dateTime!,
                      style: TextStyle(
                        fontSize: 12,
                        color: !state.isDark!
                            ? HexColor(AppColors.secondaryInActiveButtonColor)
                            : AppColors.darkLightThemeColor,
                      ),
                    ),
                    Divider(
                      color: !state.isDark!
                          ? HexColor(AppColors.secondaryInActiveButtonColor)
                          : AppColors.primaryLightThemeColor,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

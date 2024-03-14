import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/data/models/article.dart';
import 'package:newsapp/features/daily_news/presentation/bloc/article_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/active_index_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CategoryTile extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  int? currentSelected = 0;
  final int index;

  CategoryTile({
    this.index = 0,
    this.title = "",
    this.currentSelected,
    super.key,
    this.onTap,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool? isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
      builder: (context, state) {
        if (state.runtimeType == ThemeModeChangeState) {
          return InkWell(
            onTap: () {
              if (context.read<ActiveIndexCubit>().state.index !=
                  widget.index) {
                context
                    .read<ActiveIndexCubit>()
                    .changeIndex(widget.index, categories[widget.index], "US");
                setState(() {
                  isSelected = !isSelected!;
                });
                context.read<ArticleBloc>().add(GetNewsArticles(
                      country: "us",
                      category: categoriesValue[widget.index],
                    ));
              } else if (context.read<ActiveIndexCubit>().state.index ==
                  widget.index) {
                setState(() {
                  isSelected = !isSelected!;
                });
              }
            },
            child: isSelected!
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ),
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
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: !state.isDark!
                            ? HexColor(
                                AppColors.primaryBottomNavBackgroundColor)
                            : AppColors.primaryLightThemeColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: !state.isDark!
                              ? HexColor(AppColors.secondaryInActiveButtonColor)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

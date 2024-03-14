import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomCircleCategory extends StatelessWidget {
  int? index;
  VoidCallback? onTap;
  CustomCircleCategory({
    this.index = 0,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeChangeCubit>().state;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(AppImagePath.countryFlags[index!]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              countries[index!],
              style: TextStyle(
                fontSize: 12,
                color: !state.isDark!
                    ? HexColor(AppColors.secondaryInActiveButtonColor)
                    : AppColors.darkLightThemeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomThemeMode extends StatefulWidget {
  const CustomThemeMode({
    super.key,
  });

  @override
  State<CustomThemeMode> createState() => _CustomThemeModeState();
}

class _CustomThemeModeState extends State<CustomThemeMode> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
      builder: (context, state) {
        if (state.isDark!) {
          return IconButton(
            onPressed: () {
              setState(() {
                context
                    .read<ThemeModeChangeCubit>()
                    .changeThemeMode(isDark: false);
              });
            },
            icon: SvgPicture.asset(AppImagePath.darkThemeIcon,
                color: Colors.white),
          );
        } else {
          return IconButton(
            onPressed: () {
              setState(() {
                context
                    .read<ThemeModeChangeCubit>()
                    .changeThemeMode(isDark: true);
              });
            },
            icon: SvgPicture.asset(
              AppImagePath.lightThemeIcon,
              color: AppColors.primaryLightThemeColor,
            ),
          );
        }
      },
    );
  }
}

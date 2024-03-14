import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomThemeMode extends StatelessWidget {
  const CustomThemeMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newState = context.watch<ThemeModeChangeCubit>().state;
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
      builder: (context, state) {
        if (state.isDark!) {
          return IconButton(
            onPressed: () {
              context
                  .read<ThemeModeChangeCubit>()
                  .changeThemeMode(isDark: false);
            },
            icon: SvgPicture.asset(
              AppImagePath.lightThemeIcon,
              color: AppColors.primaryLightThemeColor,
            ),
          );
        } else if (state.isDark == false) {
          return IconButton(
            onPressed: () {
              context
                  .read<ThemeModeChangeCubit>()
                  .changeThemeMode(isDark: true);
              print(state.isDark);
              print(newState.isDark);
            },
            icon: !state.isDark!
                ? SvgPicture.asset(AppImagePath.darkThemeIcon,
                    color: Colors.white)
                : SvgPicture.asset(
                    AppImagePath.lightThemeIcon,
                    color: AppColors.primaryLightThemeColor,
                  ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';

class CustomNavBar extends StatefulWidget {
  int? index;
  // VoidCallback? onIndexValueChange;
  // Create a function to handle the index value change
  void Function(int index)? onIndexValueChange;

  CustomNavBar({
    super.key,
    required this.index,
    this.onIndexValueChange,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: state.isDark!
                ? HexColor(AppColors.primaryBottomNavBackgroundColor)
                : AppColors.primaryLightThemeColor,
          ),
          child: GNav(
              padding: AppGaps.paddingAll15,
              activeColor: const Color(0xFFF7F7FB),
              color: const Color(0xFFF7F7FB),
              tabBackgroundColor: state.isDark!
                  ? HexColor(AppColors.primaryActiveButtonColor)
                  : AppColors.secondaryLightThemeColor,
              gap: 10,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              curve: Curves.easeIn,
              selectedIndex: widget.index!,
              onTabChange: (value) {
                setState(() {
                  widget.index = value;
                  if (widget.onIndexValueChange != null) {
                    widget.onIndexValueChange!(value);
                  }
                });
              },
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  padding: AppGaps.paddingAll15,
                  text: 'Discover',
                  textStyle: TextStyle(
                      fontSize: 16, color: AppColors.shadeLightThemeColor1),
                ),
                GButton(
                  icon: LineIcons.search,
                  padding: AppGaps.paddingAll15,
                  text: 'Explore',
                  textStyle: TextStyle(
                      fontSize: 16, color: AppColors.shadeLightThemeColor1),
                ),
                GButton(
                  icon: LineIcons.bookmark,
                  padding: AppGaps.paddingAll15,
                  text: 'Favorites',
                  textStyle: TextStyle(
                      fontSize: 16, color: AppColors.shadeLightThemeColor1),
                ),
                GButton(
                  icon: LineIcons.user,
                  padding: AppGaps.paddingAll15,
                  text: 'Profile',
                  textStyle: TextStyle(
                      fontSize: 16, color: AppColors.shadeLightThemeColor1),
                ),
              ]),
        );
      },
    );
  }
}

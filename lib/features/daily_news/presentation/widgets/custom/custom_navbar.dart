import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:line_icons/line_icons.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: HexColor(AppColors.primaryBottomNavBackgroundColor),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: GNav(
          padding: AppGaps.paddingAll15,
          activeColor: HexColor(AppColors.primaryTextColor),
          color: HexColor(AppColors.secondaryInActiveButtonColor),
          tabBackgroundColor: HexColor(AppColors.primaryActiveButtonColor),
          gap: 10,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          curve: Curves.easeIn,
          onTabChange: (value) {},
          tabs: const [
            GButton(
                icon: LineIcons.home,
                padding: AppGaps.paddingAll15,
                text: 'Discover'),
            GButton(
                icon: LineIcons.search,
                padding: AppGaps.paddingAll15,
                text: 'Search'),
            GButton(
                icon: LineIcons.bookmark,
                padding: AppGaps.paddingAll15,
                text: 'Favorites'),
            GButton(
                icon: LineIcons.user,
                padding: AppGaps.paddingAll15,
                text: 'Profile'),
          ]),
    );
  }
}

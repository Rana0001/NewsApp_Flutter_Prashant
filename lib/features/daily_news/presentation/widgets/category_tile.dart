import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: HexColor(AppColors.primaryBottomNavBackgroundColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'Business',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: HexColor(AppColors.secondaryInActiveButtonColor),
          ),
        ),
      ),
    );
  }
}

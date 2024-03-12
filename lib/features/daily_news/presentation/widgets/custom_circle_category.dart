import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';

class CustomCircleCategory extends StatelessWidget {
  const CustomCircleCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                image: NetworkImage(
                    "https://www.usmagazine.com/wp-content/uploads/2019/07/Beyonce-Spirit-Video-Looks-1.jpg?w=1200&quality=86&strip=all"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 30,
            ),
          ),
          Text(
            'Beyonce',
            style: TextStyle(
              fontSize: 12,
              color: HexColor(AppColors.secondaryInActiveButtonColor),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

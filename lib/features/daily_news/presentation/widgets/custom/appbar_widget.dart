import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_notification.dart';

AppBar homeAppBar() {
  return AppBar(
    title: const Text('Discover',
        style: TextStyle(
          fontSize: 30,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        )),
    actions: [
      AppGaps.wGap10,
      const CustomThemeMode(),
      AppGaps.wGap10,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: 'https://avatars.githubusercontent.com/u/55942632?v=4',
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 20,
            backgroundImage: imageProvider,
          ),
          progressIndicatorBuilder: (context, url, progress) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.error),
          ),
        ),
      ),
    ],
  );
}

AppBar AppbarCustom(String title) {
  return AppBar(
    backgroundColor: HexColor(AppColors.primaryDarkBackgroundColor),
    title: Text(title,
        style: const TextStyle(
          fontSize: 30,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        )),
  );
}

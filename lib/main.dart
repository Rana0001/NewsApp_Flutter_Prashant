import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsapp/config/theme/app_theme.dart';
import 'package:newsapp/features/daily_news/presentation/pages/home_page.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_body.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_drawer.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_navbar.dart';
import 'package:newsapp/injection_controller.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeConfig.getDarkThemeData(),
      home: const HomeNewsPage(),
    );
  }
}

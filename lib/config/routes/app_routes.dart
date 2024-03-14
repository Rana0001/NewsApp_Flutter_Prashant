import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/internet_connection_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:newsapp/features/daily_news/presentation/pages/favorite_news.dart';
import 'package:newsapp/features/daily_news/presentation/pages/home_page.dart';
import 'package:newsapp/features/user/presentation/pages/login_page.dart';
import 'package:newsapp/features/user/presentation/pages/splash_screen.dart';

class AppRoutes {
  final ThemeModeChangeCubit _themeModeChangeCubit = ThemeModeChangeCubit();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _themeModeChangeCubit,
                  child: const SplashScreen(),
                ));
      case "/login":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _themeModeChangeCubit,
                  child: const LoginPage(),
                ));
      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _themeModeChangeCubit,
                  child: const HomeNewsPage(),
                ));
      case '/favourite':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _themeModeChangeCubit,
                  child: const FavoritePage(),
                ));
      case "/articleDetail":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _themeModeChangeCubit,
            child: ArticleDetailsPage(),
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _themeModeChangeCubit, child: const ErrorPage()));
    }
  }

  void dispose() {
    _themeModeChangeCubit.close();
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            context.read<ThemeModeChangeCubit>().state.isDark!
                ? SvgPicture.asset(AppImagePath.dataNotFoundDark)
                : SvgPicture.asset(AppImagePath.dataNotFoundDark),
            const Text('Error Page',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}

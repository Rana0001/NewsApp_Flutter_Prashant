import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:newsapp/config/routes/app_routes.dart';
import 'package:newsapp/config/theme/app_theme.dart';
import 'package:newsapp/core/constant/constant.dart';
import 'package:newsapp/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:newsapp/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/active_index_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/internet_connection_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/pages/article_detail_page.dart';
import 'package:newsapp/features/daily_news/presentation/pages/explore_page.dart';
import 'package:newsapp/features/daily_news/presentation/pages/home_page.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_body.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_drawer.dart';
import 'package:newsapp/features/daily_news/presentation/widgets/custom/custom_navbar.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/user/data/data_storages/remote/user_remote_services.dart';
import 'package:newsapp/features/user/presentation/bloc/user_bloc.dart';
import 'package:newsapp/features/user/presentation/pages/login_page.dart';
import 'package:newsapp/features/user/presentation/pages/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'features/daily_news/presentation/bloc/article_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: firebaseApiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId));
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(
            appRoutes: AppRoutes(),
            connectivity: Connectivity(),
          )));
}

class MyApp extends StatefulWidget {
  final AppRoutes? appRoutes;
  final Connectivity? connectivity;

  const MyApp({super.key, this.connectivity, this.appRoutes});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeModeChangeCubit _themeModeChangeCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InternetConnectionCubit>(
            create: (context) =>
                InternetConnectionCubit(connectivity: widget.connectivity),
          ),
          BlocProvider<ArticleBloc>(
            create: (context) =>
                ArticleBloc(newsApiServices: NewsApiServices()),
          ),
          BlocProvider<ActiveIndexCubit>(
            create: (context) => ActiveIndexCubit(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(UserRemoteServices()),
          ),
          BlocProvider<ThemeModeChangeCubit>(
            create: (context) => ThemeModeChangeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeModeChangeCubit, ThemeModeChangeState>(
          builder: (context, stateData) {
            if (stateData.runtimeType == ThemeModeChangeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'News App',
                themeMode: ThemeMode.dark,
                darkTheme: ThemeConfig.getDarkThemeData(),
                theme: ThemeConfig.getLightThemeData(),
                // home: const HomeNewsPage(),
                onGenerateInitialRoutes: (initialRoute) {
                  return [
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  ];
                },
                onGenerateRoute: widget.appRoutes!.onGenerateRoute,
              );
            }
            return const SizedBox();
          },
        ));
  }
}

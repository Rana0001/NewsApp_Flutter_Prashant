import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/internet_connection_cubit.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/user/presentation/bloc/user_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeModeChangeCubit>().state;
    final googleLoginState = context.read<UserBloc>();
    if (state.isDark == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pushNamed(context, "/");
          flushBarMessage(
                  "Login Successful", "Login", AppColors.successLightThemeColor)
              .show(context);
        } else if (state is UserError) {
          flushBarMessage("Something went wrong!", "Login",
                  AppColors.alertLightThemeColor)
              .show(context);
        } else if (state is UserLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      child: BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
        builder: (context, internetState) {
          if (internetState is InternetConnectionDisconnected) {
            return AlertDialog(
              title: const Text("No Internet Connection"),
              content: const Text("Please check your internet connection"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          } else if (internetState is InternetConnectionConnected) {
            return Scaffold(
              appBar: AppBar(),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    AppGaps.hGap40,
                    const Text(
                      "Welcome to News App",
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppImagePath.logoDark),
                    ),
                    AppGaps.hGap30,
                    InkWell(
                      onTap: () {
                        googleLoginState.add(const LoginUser());
                      },
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: HexColor(AppColors.primaryActiveButtonColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImagePath.google,
                              height: 40,
                            ),
                            AppGaps.wGap10,
                            const Text("Login with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ),
                    AppGaps.hGap20,
                    Text(
                      "Developed by: Prashant Rana Magar",
                      style: TextStyle(
                        fontSize: 14,
                        color: !state.isDark!
                            ? Colors.white
                            : HexColor(AppColors.secondaryInActiveButtonColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (internetState is InternetConnectionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Flushbar<dynamic> flushBarMessage(
      String? message, String? title, Color? color ) {
    return Flushbar(
      message: message,
      title: title,
      isDismissible: true,
      backgroundColor: color!,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 30,
      ),
      duration: const Duration(seconds: 3),
    );
  }
}

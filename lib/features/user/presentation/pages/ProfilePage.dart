import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/core/constant/app_colors.dart';
import 'package:newsapp/core/constant/app_gaps.dart';
import 'package:newsapp/core/constant/app_image_path.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/theme_mode_change_cubit.dart';
import 'package:newsapp/features/user/presentation/bloc/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>();
    final state = context.watch<ThemeModeChangeCubit>().state;
    String dateTime =
        DateFormat.yMMMMd().format(userState.state.userModel.dob!);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        } else if (state is UserError) {
          flushBarMessage("Something went wrong!", "Error",
                  AppColors.alertLightThemeColor)
              .show(context);
        }
      },
      child: SafeArea(
        child: Container(
          color: !state.isDark!
              ? HexColor(AppColors.primaryDarkThemeBackgroundColor)
              : AppColors.shadeLightThemeColor1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap30,
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1.2,
                          blurRadius: 30,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(
                            userState.state.userModel.photoUrl),
                      )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          "Account Creation Date",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            color: HexColor(
                                AppColors.secondaryInActiveButtonColor),
                          ),
                        ),
                        Text(
                          dateTime,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: !state.isDark!
                                ? HexColor(
                                    AppColors.secondaryInActiveButtonColor)
                                : AppColors.darkLightThemeColor,
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
              AppGaps.hGap10,
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Column(children: [
                  Text(
                    userState.state.userModel.displayName.split(" ")[0],
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: !state.isDark!
                          ? HexColor(AppColors.secondaryInActiveButtonColor)
                          : AppColors.darkLightThemeColor,
                    ),
                  ),
                  Text(
                    userState.state.userModel.displayName.split(" ")[1],
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: HexColor(
                          AppColors.secondaryInActiveButtonColor,
                        )),
                  ),
                ]),
              ),
              AppGaps.hGap25,
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: SizedBox(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: !state.isDark!
                          ? HexColor(AppColors.secondaryInActiveButtonColor)
                          : AppColors.darkLightThemeColor,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  userState.add(const DeleteUser());
                },
                splashColor: state.isDark!
                    ? AppColors.primaryLightThemeColor
                    : HexColor(AppColors.primaryActiveButtonColor),
                child: customSettingTile(
                    state,
                    "Delete Account",
                    AppImagePath.deleteIcon,
                    AppColors.primaryTileRemoveButtonLightColor),
              ),
              InkWell(
                splashColor: state.isDark!
                    ? AppColors.primaryLightThemeColor
                    : HexColor(AppColors.primaryActiveButtonColor),
                onTap: () {
                  if (!state.isDark!) {
                    context
                        .read<ThemeModeChangeCubit>()
                        .changeThemeMode(isDark: true);
                  } else if (state.isDark!) {
                    context
                        .read<ThemeModeChangeCubit>()
                        .changeThemeMode(isDark: false);
                  }
                },
                child: customSettingTile(
                    state,
                    state.isDark! ? "Dark Mode" : "Light Mode",
                    state.isDark!
                        ? AppImagePath.darkThemeIcon
                        : AppImagePath.lightThemeIcon,
                    AppColors.darkLightThemeColor),
              ),
              AppGaps.hGap20,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 80,
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, top: 20),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: !state.isDark!
                                ? HexColor(AppColors.primaryActiveButtonColor)
                                : AppColors.primaryLightThemeColor,
                            onPressed: () {
                              userState.add(const LogoutUser());
                            },
                            child: const Text("Sign Out",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.shadeLightThemeColor1)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding customSettingTile(
      ThemeModeChangeState state, String title, String icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          leading: Container(
            child: CircleAvatar(
              backgroundColor: color,
              child: SvgPicture.asset(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: !state.isDark!
                  ? HexColor(AppColors.secondaryInActiveButtonColor)
                  : AppColors.darkLightThemeColor,
            ),
          ),
          trailing: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1.2,
                  blurRadius: 30,
                  offset: const Offset(0, 3),
                ),
              ],
              color: !state.isDark!
                  ? HexColor(AppColors.primaryActiveButtonColor)
                  : AppColors.primaryTileButtonLightColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: HexColor(AppColors.secondaryInActiveButtonColor),
            ),
          ),
        ),
      ),
    );
  }
}

Flushbar<dynamic> flushBarMessage(
    String? message, String? title, Color? color) {
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

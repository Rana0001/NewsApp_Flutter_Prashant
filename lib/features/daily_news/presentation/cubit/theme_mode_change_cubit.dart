import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:newsapp/features/daily_news/presentation/cubit/internet_connection_cubit.dart';

part 'theme_mode_change_state.dart';

class ThemeModeChangeCubit extends HydratedCubit<ThemeModeChangeState> {
  ThemeModeChangeCubit() : super(_loadInitialThemeMode());

  static ThemeModeChangeState _loadInitialThemeMode() {
    final savedData = HydratedBloc.storage.read('theme_mode');
    if (savedData != null) {
      final parsedData = jsonDecode(savedData);
      return ThemeModeChangeState(isDark: parsedData['isDark']);
    } else {
      return const ThemeModeChangeState(isDark: false);
    }
  }

  void changeThemeMode({required bool? isDark}) {
    emit(ThemeModeChangeState(isDark: isDark));
  }

  @override
  ThemeModeChangeState? fromJson(Map<String, dynamic> json) {
    return ThemeModeChangeState(isDark: json['isDark']);
  }

  @override
  Map<String, dynamic>? toJson(ThemeModeChangeState state) {
    return {'isDark': state.isDark};
  }
}

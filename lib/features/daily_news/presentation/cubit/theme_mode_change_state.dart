part of 'theme_mode_change_cubit.dart';

class ThemeModeChangeState extends Equatable {
  const ThemeModeChangeState({this.isDark});
  final bool? isDark;
  @override
  List<Object?> get props => [isDark];

  ThemeModeChangeState copyWith({
    bool? isDark,
  }) {
    return ThemeModeChangeState(
      isDark: isDark ?? this.isDark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDark': isDark,
    };
  }

  factory ThemeModeChangeState.fromMap(Map<String, dynamic> map) {
    return ThemeModeChangeState(
      isDark: map['isDark'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeModeChangeState.fromJson(String source) =>
      ThemeModeChangeState.fromMap(json.decode(source));
}

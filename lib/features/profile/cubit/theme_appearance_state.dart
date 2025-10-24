part of 'theme_appearance_cubit.dart';

class ThemeAppearanceState extends Equatable {
  final ThemeMode? selectedThemeMode;

  const ThemeAppearanceState({this.selectedThemeMode});

  @override
  List<Object?> get props => [selectedThemeMode];
}

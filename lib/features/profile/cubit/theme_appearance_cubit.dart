import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_swap/core/services/once_cache_service.dart';

part 'theme_appearance_state.dart';

class ThemeAppearanceCubit extends Cubit<ThemeAppearanceState> {
  final OnceCacheService _onceCacheService;

  ThemeAppearanceCubit({required OnceCacheService onceCacheService})
    : _onceCacheService = onceCacheService,
      super(const ThemeAppearanceState(selectedThemeMode: ThemeMode.system)) {
    getThemeData();
  }

  /// Load theme from SharedPreferences
  Future<void> getThemeData() async {
    final modeString = await _onceCacheService.getThemeCache();
    ThemeMode mode = ThemeMode.system;
    if (modeString == 'light') mode = ThemeMode.light;
    if (modeString == 'dark') mode = ThemeMode.dark;
    emit(ThemeAppearanceState(selectedThemeMode: mode));
  }

  /// Change theme and save it
  Future<void> setTheme(ThemeMode mode) async {
    await _onceCacheService.setThemeCache(mode);
    emit(ThemeAppearanceState(selectedThemeMode: mode));
  }
}

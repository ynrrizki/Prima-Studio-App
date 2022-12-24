import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prima_studio/config/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: PrimaStudioThemes.lightTheme));

  void toggleTheme(bool value) {
    if (value) {
      final updateState = ThemeState(theme: PrimaStudioThemes.darkTheme);
      emit(updateState);
    } else {
      final updateState = ThemeState(theme: PrimaStudioThemes.lightTheme);
      emit(updateState);
    }
  }
}

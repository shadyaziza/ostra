import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemeService with ListenableServiceMixin {
  AppColors colors;

  ThemeService({required this.colors}) {
    listenToReactiveValues([_themeData]);
  }

  AppColors get lightColors => LightAppColors();
  AppColors get darkColors => DarkAppColors();

  late ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      notifyListeners();
      return;
    }

    if (_themeData == lightTheme) {
      _themeData = darkTheme;
      notifyListeners();
      return;
    }
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: darkColors.primary,
      primaryColorDark: darkColors.primary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColors.primary,
      ),
      brightness: Brightness.dark,
    );
  }

  ThemeData get lightTheme {
    return ThemeData();
  }
}

sealed class AppColors {
  Color get primary;
  Color get card;
}

class LightAppColors implements AppColors {
  @override
  Color get card => Colors.black12;

  @override
  Color get primary => const Color(0xFF005C4A);
}

class DarkAppColors implements AppColors {
  @override
  Color get card => Colors.white10;

  @override
  Color get primary => const Color(0xFF00E5B7);
}

class AppColorsService {}

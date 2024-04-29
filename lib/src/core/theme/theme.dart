import 'package:flutter/material.dart';
import 'package:ostra/src/common/common.dart';

part 'theme.g.dart';

@riverpod
ThemeService themeService(ThemeServiceRef ref) => ThemeService();

class ThemeService {
  ThemeService();

  AppColors get lightColors => LightAppColors();
  AppColors get darkColors => DarkAppColors();

  late ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  bool get isDark => _themeData == darkTheme;

  void toggleTheme() {
    if (_themeData == darkTheme) {
      _themeData = lightTheme;

      return;
    }

    if (_themeData == lightTheme) {
      _themeData = darkTheme;

      return;
    }
  }

  ThemeData get darkTheme {
    // TODO(shadyaziza): extract colors
    return ThemeData(
      useMaterial3: true,
      primaryColor: darkColors.primary,
      primaryColorDark: darkColors.primary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColors.primary,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: darkColors.primary,
        onPrimary: Colors.white,
        secondary: Colors.blue,
        onSecondary: Colors.black,
        error: Colors.redAccent,
        onError: Colors.white,
        background: darkColors.backgroundColor,
        onBackground: Colors.white70,
        surface: darkColors.surface,
        onSurface: Colors.white,
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
  Color get backgroundColor;
  Color get surface;
}

class LightAppColors implements AppColors {
  @override
  Color get card => Colors.black12;

  @override
  Color get primary => const Color(0xFF005C4A);

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get surface => const Color(0xFF222529);
}

class DarkAppColors implements AppColors {
  @override
  Color get card => Colors.white10;

  @override
  Color get primary => const Color(0xFF00E5B7);

  @override
  Color get backgroundColor => const Color(0xFF202226);

  @override
  Color get surface => const Color(0xFF222529);
}

class AppColorsService {}

extension AppTheme on ThemeData {
  Color get primary => colorScheme.primary;
  Color get onPrimary => colorScheme.onPrimary;
  Color get onSecondary => colorScheme.onSecondary;
  Color get surface => colorScheme.surface;
  Color get onSurface => colorScheme.onSurface;
  Color get background => colorScheme.background;
  Color get onBackground => colorScheme.onBackground;
}

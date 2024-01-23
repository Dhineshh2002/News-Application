import 'package:flutter/material.dart';

///
/// ColorSchemes are generated from this website
/// https://m3.material.io/theme-builder#/custom
///

const String defaultFontFamily = 'Oxygen';

///
TextTheme textTheme = const TextTheme(
  bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
  titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
  headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
  displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
  displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00639B),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFCEE5FF),
  onPrimaryContainer: Color(0xFF001D33),
  secondary: Color(0xFF4259A9),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDCE1FF),
  onSecondaryContainer: Color(0xFF00164F),
  tertiary: Color(0xFF4F57A9),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE0E0FF),
  onTertiaryContainer: Color(0xFF020865),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFCFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFE7EFFF),
  onSurfaceVariant: Color(0xFF42474E),
  outline: Color(0xFF72777F),
  onInverseSurface: Color(0xFFF0F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF96CCFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00639B),
  outlineVariant: Color(0xFFA6CAFF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF96CCFF),
  onPrimary: Color(0xFF003353),
  primaryContainer: Color(0xFF004A76),
  onPrimaryContainer: Color(0xFFCEE5FF),
  secondary: Color(0xFFB6C4FF),
  onSecondary: Color(0xFF082978),
  secondaryContainer: Color(0xFF284190),
  onSecondaryContainer: Color(0xFFDCE1FF),
  tertiary: Color(0xFFBEC2FF),
  onTertiary: Color(0xFF1E2678),
  tertiaryContainer: Color(0xFF363E90),
  onTertiaryContainer: Color(0xFFE0E0FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE2E2E5),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE2E2E5),
  surfaceVariant: Color(0xFF414141),
  onSurfaceVariant: Color(0xFFC2C7CF),
  outline: Color(0xFF8C9198),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE2E2E5),
  inversePrimary: Color(0xFF00639B),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF96CCFF),
  outlineVariant: Color(0xFF42474E),
  scrim: Color(0xFF000000),
);

/// Light Theme
/// The colors in [lightThemeData] MUST be used from [lightColorScheme]
///
ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  fontFamily: defaultFontFamily,
  textTheme: textTheme.apply(bodyColor: lightColorScheme.onBackground),
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.outlineVariant,
    toolbarTextStyle: textTheme.titleLarge,
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: lightColorScheme.background,
    ),
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightColorScheme.surfaceVariant,
      selectedItemColor: lightColorScheme.primary,
    )
);

///
/// DarkTheme Theme
/// The colors in [darkThemeData] MUST be used from [darkColorScheme]
///
ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  fontFamily: defaultFontFamily,
  scaffoldBackgroundColor: darkColorScheme.background,
  textTheme: textTheme.apply(bodyColor: darkColorScheme.onBackground),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surfaceVariant,
    toolbarTextStyle: textTheme.titleLarge,
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: darkColorScheme.background,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.surfaceVariant,
    selectedItemColor: darkColorScheme.primary,
  ),

);

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Application theme class
class AppTheme {
  AppTheme._();

  /// Light Theme
  static ThemeData lightTheme = FlexThemeData.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    scheme: FlexScheme.gold,
    surfaceTint: Colors.transparent,
    textTheme: const TextTheme(),
    dialogBackground: const Color.fromARGB(255, 174, 174, 174),
    secondary: const Color.fromARGB(255, 238, 238, 238),
    secondaryContainer: const Color.fromARGB(255, 252, 245, 245),
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
  );

  /// Dark Theme
  static ThemeData darkTheme = FlexThemeData.dark(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    dialogBackground: Colors.grey.shade800,
    secondary: const Color.fromARGB(255, 15, 15, 15),
    secondaryContainer: const Color.fromARGB(255, 5, 5, 5),
    scheme: FlexScheme.deepPurple,
    surfaceTint: Colors.transparent,
    tabBarStyle: FlexTabBarStyle.forBackground,
  );
}

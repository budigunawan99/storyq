import 'package:flutter/material.dart';
import 'package:storyq/style/colors/storyq_colors.dart';
import 'package:storyq/style/typography/storyq_text_style.dart';

class StoryqTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: lightColorScheme,
      focusColor: _lightFocusColor,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _lightAppBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: darkColorScheme,
      focusColor: _darkFocusColor,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _darkAppBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: StoryqTextStyle.displayLarge,
      displayMedium: StoryqTextStyle.displayMedium,
      displaySmall: StoryqTextStyle.displaySmall,
      headlineLarge: StoryqTextStyle.headlineLarge,
      headlineMedium: StoryqTextStyle.headlineMedium,
      headlineSmall: StoryqTextStyle.headlineSmall,
      titleLarge: StoryqTextStyle.titleLarge,
      titleMedium: StoryqTextStyle.titleMedium,
      titleSmall: StoryqTextStyle.titleSmall,
      bodyLarge: StoryqTextStyle.bodyLargeBold,
      bodyMedium: StoryqTextStyle.bodyLargeMedium,
      bodySmall: StoryqTextStyle.bodyLargeRegular,
      labelLarge: StoryqTextStyle.labelLarge,
      labelMedium: StoryqTextStyle.labelMedium,
      labelSmall: StoryqTextStyle.labelSmall,
    );
  }

  static AppBarTheme get _lightAppBarTheme {
    return AppBarTheme(
      backgroundColor: StoryqColors.white.color,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: StoryqColors.boldPink.color,
      ),
      actionsIconTheme: IconThemeData(
        color: StoryqColors.boldPink.color,
        size: 14.0,
      ),
    );
  }

  static AppBarTheme get _darkAppBarTheme {
    return AppBarTheme(
      backgroundColor: StoryqColors.darkGreen.color,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: StoryqColors.softGreen.color,
      ),
      actionsIconTheme: IconThemeData(
        color: StoryqColors.softGreen.color,
        size: 14.0,
      ),
    );
  }

  static ColorScheme lightColorScheme = ColorScheme(
    primary: StoryqColors.darkPink.color,
    onPrimary: StoryqColors.lightPink.color,
    secondary: StoryqColors.mediumPink.color,
    onSecondary: StoryqColors.black.color,
    error: StoryqColors.red.color,
    onError: StoryqColors.white.color,
    surface: StoryqColors.lightPink.color,
    onSurface: StoryqColors.boldPink.color,
    brightness: Brightness.light,
    surfaceContainer: StoryqColors.lightPink.color,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: StoryqColors.darkGreen.color,
    onPrimary: StoryqColors.softGreen.color,
    secondary: StoryqColors.lightGreen.color,
    onSecondary: StoryqColors.darkGreen.color,
    error: StoryqColors.red.color,
    onError: StoryqColors.white.color,
    surface: StoryqColors.mediumGreen.color,
    onSurface: StoryqColors.softGreen.color,
    brightness: Brightness.dark,
    surfaceContainer: StoryqColors.lightGreen.color,
  );

  static final Color _lightFocusColor = Colors.black.withValues(alpha: 0.12);
  static final Color _darkFocusColor = Colors.white.withValues(alpha: 0.12);
}

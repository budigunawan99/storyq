import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/provider/settings/theme_shared_preferences_provider.dart';
import 'package:storyq/style/colors/storyq_colors.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  void initState() {
    super.initState();
    final themeSharedPreferencesProvider =
        context.read<ThemeSharedPreferencesProvider>();
    final themeProvider = context.read<ThemeProvider>();

    Future.microtask(() async {
      themeSharedPreferencesProvider.getTheme();
      final theme = themeSharedPreferencesProvider.currentTheme;
      if (theme != null) {
        themeProvider.setDarkMode(theme);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          isSelected: themeProvider.isDarkMode,
          onPressed: () async {
            themeProvider.setDarkMode(!themeProvider.isDarkMode);
            final themeSharedPreferencesProvider =
                context.read<ThemeSharedPreferencesProvider>();
            try {
              await themeSharedPreferencesProvider.saveTheme(
                themeProvider.isDarkMode,
              );
            } catch (e) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(themeSharedPreferencesProvider.message),
                    backgroundColor: StoryqColors.red.color,
                  ),
                );
              });
            }
          },
          selectedIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Icon(
              Icons.brightness_2_outlined,
              size: 25,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Icon(
              Icons.wb_sunny_outlined,
              size: 25,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      },
    );
  }
}

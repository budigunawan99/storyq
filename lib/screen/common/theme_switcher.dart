import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          isSelected: themeProvider.isDarkMode,
          onPressed: () {
            themeProvider.setDarkMode(!themeProvider.isDarkMode);
          },
          selectedIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Icon(Icons.brightness_2_outlined, size: 25),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Icon(Icons.wb_sunny_outlined, size: 25),
          ),
        );
      },
    );
  }
}

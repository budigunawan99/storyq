import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/style/colors/storyq_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.watch<ThemeProvider>().isDarkMode
                ? Image.asset(
                  "assets/images/splash_dark.png",
                  width: 150,
                  height: 150,
                )
                : Image.asset(
                  "assets/images/splash_light.png",
                  width: 150,
                  height: 150,
                ),
          ],
        ),
      ),
    );
  }
}

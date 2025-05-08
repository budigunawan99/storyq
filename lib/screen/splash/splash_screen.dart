import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              axisAlignment: -1,
              child:
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
            ),
          ],
        ),
      ),
    );
  }
}

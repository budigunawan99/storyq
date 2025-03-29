import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/screen/home/home_screen.dart';
import 'package:storyq/static/navigation_route.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "storyq",
          initialRoute: NavigationRoute.homeRoute.name,
          routes: {
            NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}

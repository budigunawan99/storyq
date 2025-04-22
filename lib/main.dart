import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/routes/router_delegate.dart';
import 'package:storyq/screen/detail/detail_screen.dart';
import 'package:storyq/screen/home/home_screen.dart';
import 'package:storyq/style/theme/storyq_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "storyq",
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: StoryqTheme.lightTheme,
          darkTheme: StoryqTheme.darkTheme,
          home: Router(
            routerDelegate: myRouterDelegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        );
      },
    );
  }
}

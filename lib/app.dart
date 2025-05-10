import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/config/flavor/flavor_config.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/provider/settings/localizations_provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/routes/route_information_parser.dart';
import 'package:storyq/routes/router_delegate.dart';
import 'package:storyq/style/theme/storyq_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();

    final authRepository = context.read<AuthRepository>();

    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.instance.values.titleApp,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: StoryqTheme.lightTheme,
          darkTheme: StoryqTheme.darkTheme,
          routerDelegate: myRouterDelegate,
          routeInformationParser: myRouteInformationParser,
          backButtonDispatcher: RootBackButtonDispatcher(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: context.watch<LocalizationProvider>().locale,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storyq/common.dart';
import 'package:storyq/config/web/url_strategy.dart';
import 'package:storyq/data/api/api_services.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/data/local/theme_shared_preferences_service.dart';
import 'package:storyq/provider/auth/auth_provider.dart';
import 'package:storyq/provider/create/create_story_provider.dart';
import 'package:storyq/provider/detail/story_detail_provider.dart';
import 'package:storyq/provider/home/story_list_provider.dart';
import 'package:storyq/provider/settings/localizations_provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/provider/settings/theme_shared_preferences_provider.dart';
import 'package:storyq/routes/route_information_parser.dart';
import 'package:storyq/routes/router_delegate.dart';
import 'package:storyq/style/theme/storyq_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        Provider(create: (context) => AuthRepository(prefs)),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create:
              (context) => AuthProvider(
                context.read<AuthRepository>(),
                context.read<ApiServices>(),
              ),
        ),
        Provider(create: (context) => ThemeSharedPreferencesService(prefs)),
        ChangeNotifierProvider(
          create:
              (context) => ThemeSharedPreferencesProvider(
                context.read<ThemeSharedPreferencesService>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => StoryListProvider(
                context.read<ApiServices>(),
                context.read<AuthRepository>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => StoryDetailProvider(
                context.read<ApiServices>(),
                context.read<AuthRepository>(),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => CreateStoryProvider(
                context.read<ApiServices>(),
                context.read<AuthRepository>(),
              ),
        ),
        ChangeNotifierProvider(create: (context) => LocalizationProvider()),
      ],
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
          title: "storyq",
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storyq/app.dart';
import 'package:storyq/config/flavor/flavor_config.dart';
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

void main() async {
  FlavorConfig(
    flavor: FlavorType.pro,
    values: const FlavorValues(titleApp: "Storyq Pro"),
  );
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

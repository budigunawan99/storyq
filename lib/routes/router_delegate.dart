import 'package:flutter/material.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/data/model/page_configuration.dart';
import 'package:storyq/screen/common/unknown_screen.dart';
import 'package:storyq/screen/create/create_story_screen.dart';
import 'package:storyq/screen/detail/detail_screen.dart';
import 'package:storyq/screen/home/home_screen.dart';
import 'package:storyq/screen/login/login_screen.dart';
import 'package:storyq/screen/register/register_screen.dart';
import 'package:storyq/screen/settings/settings_screen.dart';
import 'package:storyq/screen/splash/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(this.authRepository)
    : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  String? selectedStory;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  bool isSettingsPage = false;
  bool isCreateStoryPage = false;

  bool? isUnknown;

  @override
  Widget build(BuildContext context) {
    if (isUnknown == true) {
      historyStack = _unknownStack;
    } else if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onDidRemovePage: (page) {
        if (page.key == ValueKey("DetailPage-$selectedStory")) {
          selectedStory = null;
          notifyListeners();
        }
        if (page.key == const ValueKey("RegisterPage")) {
          isRegister = false;
          notifyListeners();
        }
        if (page.key == const ValueKey("SettingsPage")) {
          isSettingsPage = false;
          notifyListeners();
        }
        if (page.key == const ValueKey("CreateStoryPage")) {
          isCreateStoryPage = false;
          notifyListeners();
        }
        if (page.key == const ValueKey("UnknownPage")) {
          isUnknown = false;
          notifyListeners();
        }
      },
    );
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return SplashPageConfiguration();
    } else if (isRegister == true) {
      return RegisterPageConfiguration();
    } else if (isLoggedIn == false) {
      return LoginPageConfiguration();
    } else if (isUnknown == true) {
      return UnknownPageConfiguration();
    } else if (isSettingsPage == true) {
      return SettingsPageConfiguration();
    } else if (isCreateStoryPage == true) {
      return CreateStoryPageConfiguration();
    } else if (selectedStory == null) {
      return HomePageConfiguration();
    } else if (selectedStory != null) {
      return DetailPageConfiguration(selectedStory!);
    } else {
      return null;
    }
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    switch (configuration) {
      case UnknownPageConfiguration():
        isUnknown = true;
        isRegister = false;
        isSettingsPage = false;
        isCreateStoryPage = false;
        break;
      case RegisterPageConfiguration():
        isUnknown = false;
        selectedStory = null;
        isSettingsPage = false;
        isCreateStoryPage = false;
        isRegister = true;
        break;
      case HomePageConfiguration() ||
          LoginPageConfiguration() ||
          SplashPageConfiguration():
        isUnknown = false;
        selectedStory = null;
        isRegister = false;
        isSettingsPage = false;
        isCreateStoryPage = false;
        break;
      case DetailPageConfiguration():
        isUnknown = false;
        isRegister = false;
        isSettingsPage = false;
        isCreateStoryPage = false;
        selectedStory = configuration.storyId.toString();
        break;
      case SettingsPageConfiguration():
        isUnknown = false;
        isRegister = false;
        selectedStory = null;
        isCreateStoryPage = false;
        isSettingsPage = true;
        break;
      case CreateStoryPageConfiguration():
        isUnknown = false;
        isRegister = false;
        selectedStory = null;
        isSettingsPage = false;
        isCreateStoryPage = true;
        break;
    }

    notifyListeners();
  }

  List<Page> get _unknownStack => const [
    MaterialPage(key: ValueKey("UnknownPage"), child: UnknownScreen()),
  ];

  List<Page> get _splashStack => const [
    MaterialPage(key: ValueKey("SplashPage"), child: SplashScreen()),
  ];
  List<Page> get _loggedOutStack => [
    MaterialPage(
      key: const ValueKey("LoginPage"),
      child: LoginScreen(
        onLogin: () {
          isLoggedIn = true;
          notifyListeners();
        },
        onRegister: () {
          isRegister = true;
          notifyListeners();
        },
      ),
    ),
    if (isRegister == true)
      MaterialPage(
        key: const ValueKey("RegisterPage"),
        child: RegisterScreen(
          onLogin: () {
            isRegister = false;
            notifyListeners();
          },
          onRegister: () {
            isRegister = false;
            notifyListeners();
          },
        ),
      ),
  ];
  List<Page> get _loggedInStack => [
    MaterialPage(
      key: const ValueKey("HomePage"),
      child: HomeScreen(
        onTapped: (String storyId) {
          selectedStory = storyId;
          notifyListeners();
        },
        toSettingsPage: () {
          isSettingsPage = true;
          notifyListeners();
        },
        toCreateStoryPage: () {
          isCreateStoryPage = true;
          notifyListeners();
        },
      ),
    ),
    if (selectedStory != null)
      MaterialPage(
        key: ValueKey("DetailPage-$selectedStory"),
        child: DetailScreen(storyId: selectedStory!),
      ),

    if (isSettingsPage)
      MaterialPage(
        key: const ValueKey("SettingsPage"),
        child: SettingsScreen(
          onLogout: () {
            isLoggedIn = false;
            notifyListeners();
          },
        ),
      ),

    if (isCreateStoryPage)
      MaterialPage(
        key: const ValueKey("CreateStoryPage"),
        child: CreateStoryScreen(
          onPosted: () {
            isCreateStoryPage = false;
            notifyListeners();
          },
        ),
      ),
  ];
}

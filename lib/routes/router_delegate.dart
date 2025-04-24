import 'package:flutter/material.dart';
import 'package:storyq/data/local/auth_repository.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/screen/detail/detail_screen.dart';
import 'package:storyq/screen/home/home_screen.dart';
import 'package:storyq/screen/login/login_screen.dart';
import 'package:storyq/screen/register/register_screen.dart';
import 'package:storyq/screen/splash/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
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

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
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
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }

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
        stories: stories,
        onTapped: (String storyId) {
          selectedStory = storyId;
          notifyListeners();
        },
        onLogout: () {
          isLoggedIn = false;
          notifyListeners();
        },
      ),
    ),
    if (selectedStory != null)
      MaterialPage(
        key: ValueKey("DetailPage-$selectedStory"),
        child: DetailScreen(storyId: selectedStory!),
      ),
  ];
}

import 'package:flutter/material.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/screen/detail/detail_screen.dart';
import 'package:storyq/screen/home/home_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  String? selectedStory;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey("HomePage"),
          child: HomeScreen(
            stories: stories,
            onTapped: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey("DetailPage-$selectedStory"),
            child: DetailScreen(storyId: selectedStory!),
          ),
      ],
      onDidRemovePage: (page) {
        if (page.key == ValueKey("DetailPage-$selectedStory")) {
          selectedStory = null;
          notifyListeners();
        }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}

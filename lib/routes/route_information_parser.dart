import 'package:flutter/material.dart';
import 'package:storyq/data/model/page_configuration.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return HomePageConfiguration();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return HomePageConfiguration();
      } else if (first == 'login') {
        return LoginPageConfiguration();
      } else if (first == 'register') {
        return RegisterPageConfiguration();
      } else if (first == 'splash') {
        return SplashPageConfiguration();
      } else if (first == 'settings') {
        return SettingsPageConfiguration();
      } else if (first == 'create-story') {
        return CreateStoryPageConfiguration();
      } else if (first == 'choose-location') {
        return ChooseLocationPageConfiguration();
      } else {
        return UnknownPageConfiguration();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1];
      if (first == 'detail') {
        return DetailPageConfiguration(second);
      } else {
        return UnknownPageConfiguration();
      }
    } else {
      return UnknownPageConfiguration();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    return switch (configuration) {
      UnknownPageConfiguration() => RouteInformation(
        uri: Uri.parse("/unknown"),
      ),
      SplashPageConfiguration() => RouteInformation(uri: Uri.parse("/splash")),
      RegisterPageConfiguration() => RouteInformation(
        uri: Uri.parse("/register"),
      ),
      LoginPageConfiguration() => RouteInformation(uri: Uri.parse("/login")),
      HomePageConfiguration() => RouteInformation(uri: Uri.parse("/")),
      SettingsPageConfiguration() => RouteInformation(
        uri: Uri.parse("/settings"),
      ),
      CreateStoryPageConfiguration() => RouteInformation(
        uri: Uri.parse("/create-story"),
      ),
      ChooseLocationPageConfiguration() => RouteInformation(
        uri: Uri.parse("/choose-location"),
      ),
      DetailPageConfiguration() => RouteInformation(
        uri: Uri.parse("/detail/${configuration.storyId}"),
      ),
    };
  }
}

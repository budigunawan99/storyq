sealed class PageConfiguration {}

final class SplashPageConfiguration extends PageConfiguration {}

final class LoginPageConfiguration extends PageConfiguration {}

final class RegisterPageConfiguration extends PageConfiguration {}

final class HomePageConfiguration extends PageConfiguration {}

final class DetailPageConfiguration extends PageConfiguration {
  final String? storyId;

  DetailPageConfiguration(this.storyId);
}

final class SettingsPageConfiguration extends PageConfiguration {}

final class CreateStoryPageConfiguration extends PageConfiguration {}

final class ChooseLocationPageConfiguration extends PageConfiguration {}

final class UnknownPageConfiguration extends PageConfiguration {}

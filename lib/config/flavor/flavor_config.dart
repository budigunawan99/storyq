enum FlavorType { trial, pro }

class FlavorValues {
  final String titleApp;

  const FlavorValues({this.titleApp = "Storyq Trial"});
}

class FlavorConfig {
  final FlavorType flavor;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavor = FlavorType.trial,
    this.values = const FlavorValues(),
  }) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}

enum AppEnvironment {
  dev,
  uat,
  prod;

  static AppEnvironment fromString(String? name) {
    return values.firstWhere(
      (AppEnvironment v) => v.name.toLowerCase() == name?.toLowerCase(),
      orElse: () => AppEnvironment.dev,
    );
  }
}

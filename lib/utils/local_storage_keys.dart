enum LocalStorageKeys {
  userModelKey(key: "userModel"),
  firstAppLunch(key: "firsAppLunch"),
  currentLanguages(key: "lang");

  final String key;

  const LocalStorageKeys({required this.key});
  String getKey() => key;
}

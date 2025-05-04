extension ConvertToUrl on String {
  String convertToUrl() {
    final normalizedPath = replaceAll('\\', '/');

    return normalizedPath;
  }
}

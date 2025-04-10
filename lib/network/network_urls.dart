class NetworkURLs {
  static String _secureUrlPrefix = "https://";
  static String _unSecureUrlPrefix = "http://";
  // static String _serverUrl = "127.0.0.1";
  static String _serverUrl = "7-daysmart.com";
  static String _systemPrefix = "system";
  static String _port = "3000";

  static String getApiServer({bool? secure}) {
    return secure ?? false
        ? "$_secureUrlPrefix$_serverUrl:$_port${_systemPrefix != '' ? "/$_systemPrefix" : ''}"
        : "$_unSecureUrlPrefix$_serverUrl:$_port${_systemPrefix != '' ? "/$_systemPrefix" : ''}";
  }
}

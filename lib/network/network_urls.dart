class NetworkURLs {
  static String _secureUrlPrefix = "https://";
  static String _unSecureUrlPrefix = "https://";
  // static String _serverUrl = "192.168.1.104";
  static String _serverUrl = "7-daysmart.com";
  static String _systemPrefix = "system";
  // static String _systemPrefix = "";
  // static String _port = "3001";
  // static String _port = "3000";
  static String _port = "";

  static String getApiServer({bool? secure}) {
    return secure ?? false
        ? "$_secureUrlPrefix$_serverUrl${_port != '' ? ":$_port" : ''}${_systemPrefix != '' ? "/$_systemPrefix" : ''}"
        : "$_unSecureUrlPrefix$_serverUrl${_port != '' ? ":$_port" : ''}${_systemPrefix != '' ? "/$_systemPrefix" : ''}";
  }

  static String getMediaServer({bool? secure}) {
    return secure ?? false
        ? "$_secureUrlPrefix$_serverUrl${_port != '' ? ":$_port" : ''}/${_systemPrefix != '' ? _systemPrefix : ''}/"
        : "$_unSecureUrlPrefix$_serverUrl${_port != '' ? ":$_port" : ''}/${_systemPrefix != '' ? _systemPrefix : ''}/";
  }
}

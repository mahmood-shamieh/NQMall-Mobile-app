class NetworkURLs {
  String _secureUrlPrefix = "https://";
  String _unSecureUrlPrefix = "http://";
  String _serverUrl = "127.0.0.1";
  String _port = "3001";

  String getApiServer({bool? secure}) {
    return secure ?? false
        ? "$_secureUrlPrefix$_serverUrl:$_port"
        : "$_unSecureUrlPrefix$_serverUrl:$_port";
  }
}

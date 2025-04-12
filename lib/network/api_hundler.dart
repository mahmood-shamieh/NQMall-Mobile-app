import 'dart:convert';
import 'dart:io';
import 'package:app/exceptions/no_internet_excpetion.dart';
import 'package:app/exceptions/unauthorized_exception.dart';
import 'package:app/exceptions/view_exception.dart';
import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';

class ApiHandler {
  final String baseUrl;
  Map<String, String>? defaultHeaders = {'Content-Type': 'application/json'};
  final Duration timeout;

  ApiHandler({
    required this.baseUrl,
    this.defaultHeaders,
    this.timeout = const Duration(seconds: 10),
  });
  // void addAuthHeader(String token) {
  //   defaultHeaders!['Authorization'] = 'Bearer $token';
  // }

  // Future<bool> _checkConnectivity() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }

  Future<Map> _request(String endpoint, String method,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    // if (!await _checkConnectivity()) {
    //   throw NoInternetException();
    // }

    final url = Uri.parse('$baseUrl$endpoint');
    final requestHeaders = {
      ...defaultHeaders!,
      if (headers != null) ...headers
    };

    try {
      late http.Response response;

      switch (method) {
        case 'GET':
          response =
              await http.get(url, headers: requestHeaders).timeout(timeout);
          break;
        case 'POST':
          response = await http
              .post(url, headers: requestHeaders, body: jsonEncode(body))
              .timeout(timeout);
          break;
        case 'PUT':
          response = await http
              .put(url, headers: requestHeaders, body: jsonEncode(body))
              .timeout(timeout);
          break;
        case 'DELETE':
          response =
              await http.delete(url, headers: requestHeaders).timeout(timeout);
          break;
        default:
          throw Exception("Invalid HTTP method");
      }

      return _handleResponse(response)
          // .map((key, value) => MapEntry(key, value.toString()))
          ;
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoInternetException();
    } catch (e) {
      rethrow;
    }
  }

  Map _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw Exception("Bad Request: ${response.body}");
      case 401:
        throw Exception("Unauthorized: ${response.body}");
      case 403:
        throw UnAuthorizedException(
            statusCode: response.statusCode,
            message: json.decode(response.body)['message'],
            data: null);
      case 404:
        throw Exception("Not Found: ${response.body}");
      case 500:
        {
          Map decodedResponse = json.decode(response.body);
          if (decodedResponse.keys.contains("code")) {
            throw ViewException(
                statusCode: decodedResponse['code'],
                message: decodedResponse['message'],
                data: null);
          } else {
            throw Exception("Server Error: ${response.body}");
          }
        }
      default:
        throw Exception(
            "Unexpected Error: ${response.statusCode} - ${response.body}");
    }
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) =>
      _request(endpoint, 'GET', headers: headers);
  Future<dynamic> post(String endpoint,
          {Map<String, dynamic>? body, Map<String, String>? headers}) =>
      _request(endpoint, 'POST', body: body, headers: headers);
  Future<dynamic> put(String endpoint,
          {Map<String, dynamic>? body, Map<String, String>? headers}) =>
      _request(endpoint, 'PUT', body: body, headers: headers);
  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) =>
      _request(endpoint, 'DELETE', headers: headers);
}

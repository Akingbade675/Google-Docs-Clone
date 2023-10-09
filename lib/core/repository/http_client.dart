import 'dart:convert';

import 'package:google_docs_clone/config/app_config.dart';
import 'package:http/http.dart';

class HttpClient {
  final Client _client;

  HttpClient({required Client client}) : _client = client;
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    return await _handleResquest(
      () => _client.get(
        Uri.parse('${AppConfig.baseUrl}$url'),
        headers: _getHeaders(headers ?? {}),
      ),
    );
  }

  Future<String> post(String url,
      {Map<String, String>? headers, Map<String, String>? body}) async {
    return await _handleResquest(
      () => _client.post(
        Uri.parse('${AppConfig.baseUrl}$url'),
        headers: _getHeaders(headers ?? {}),
        body: jsonEncode(body),
      ),
    );
  }

  Map<String, String> _getHeaders(Map<String, String> headers) {
    return {...headers, 'Content-Type': 'application/json; charset=UTF-8'};
  }

  Future<String> _handleResquest(Future<Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        // ignore: avoid_print
        print(response.body);
        throw Exception(response.body);
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw e.toString();
    }
  }

  // Future<dynamic> put(String url, {Map<String, String> headers, dynamic body});

  // Future<dynamic> delete(String url, {Map<String, String> headers});

  // Future<dynamic> patch(String url,
  //     {Map<String, String> headers, dynamic body});
}

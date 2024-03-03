import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkClient {
  NetworkClient();

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri uri = Uri.parse(path);
    if (queryParameters != null) {
      uri = uri.replace(query: _encodeQueryParameters(queryParameters));
    }

    try {
      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network request failed: $e');
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(path);

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network request failed: $e');
    }
  }

  String _encodeQueryParameters(Map<String, dynamic> parameters) {
    return parameters.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

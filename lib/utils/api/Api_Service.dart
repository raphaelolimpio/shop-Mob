import 'dart:convert';
import 'package:http/http.dart' as http;

enum HttpVerb { get, post, put, delete }

class ApiResponse<T> {
  final T? data;
  final int statusCode;

  ApiResponse({required this.data, required this.statusCode});
}

class ApiService {
  static Future<ApiResponse<T>> request<T>({
    required String url,
    required HttpVerb verb,

    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required T Function(dynamic json) fromJson,
  }) async {
    http.Response? response;
    final defaultHeaders = {'Content-Type': 'application/json', ...?headers};

    try {
      switch (verb) {
        case HttpVerb.get:
          response = await http.get(Uri.parse(url), headers: defaultHeaders);
          break;
        case HttpVerb.post:
          response = await http.post(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case HttpVerb.put:
          response = await http.put(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case HttpVerb.delete:
          response = await http.delete(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        final data = fromJson(decoded);
        return ApiResponse<T>(data: data, statusCode: response.statusCode);
      } else {
        return ApiResponse<T>(data: null, statusCode: response.statusCode);
      }
    } catch (e) {
      print('Error during API request: $e');
      return ApiResponse<T>(data: null, statusCode: 500);
    }
  }
}

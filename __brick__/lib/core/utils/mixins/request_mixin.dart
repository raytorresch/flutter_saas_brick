import 'dart:convert';

import 'package:{{projectName}}/core/core.dart';
import 'package:dio/dio.dart';

enum RequestMethod { get, post, put, delete }

mixin class RequestMixin {
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest<T>(
      path: path,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> post<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest<T>(
      path: path,
      method: RequestMethod.post,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> put<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest<T>(
      path: path,
      method: RequestMethod.put,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest<T>(
      path: path,
      method: RequestMethod.delete,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<T> _sendRequest<T>({
    required String path,
    RequestMethod method = RequestMethod.get,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = getIt<Dio>();

    try {
      final response = await dio.request<T>(
        path,
        data: jsonEncode(body),
        queryParameters: queryParameters,
        options: Options(
          method: method.name.toUpperCase(),
          headers: headers,
        ),
      );

      final statusCode = response.statusCode ?? 0;
      if (statusCode < 200 || statusCode >= 300) {
        if (statusCode == 408) {
          throw const TimeoutException();
        }

        final data = response.data as Map<String, dynamic>?;

        if (data == null) {
          throw const ServerException(message: 'Error desconocido del servidor');
        }

        throw ServerException(message: data['message'] as String? ?? 'Error desconocido del servidor');
      }

      return response.data!;
    } on DioException {
      throw const ServerException(message: 'Error desconocido del servidor');
    }
  }
}

import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:your_ai/core/storage/spref/spref.dart';

final String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

class JarvisDioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 6000),
      receiveTimeout: const Duration(seconds: 6000),
      responseType: ResponseType.json,
      contentType: 'application/json',
      validateStatus: (status) => status != 401,
    ),
  );

  bool _isRefreshingToken = false;
  bool _isRetrying = false;
  Completer<String?>? _refreshCompleter;

  JarvisDioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await getJarvisAccessToken();

        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 && !_isRetrying) {
          _isRetrying = true;

          try {
            final newAccessToken =
                await getJarvisAccessToken(forceRefresh: false);

            // Retry request with new access token
            error.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final retryResponse = await _dio.fetch(error.requestOptions);
            _isRetrying = false;
            return handler.resolve(retryResponse);
          } catch (e) {
            _isRetrying = false;
            return handler.next(error);
          }
        } else {
          return handler.next(error);
        }
      },
    ));
  }

  Future<String?> getJarvisAccessToken({bool forceRefresh = false}) async {
    String? accessToken = await SPref.instance.getJarvisAccessToken();

    if (forceRefresh || accessToken == null || accessToken.isEmpty) {
      if (_isRefreshingToken) {
        return _refreshCompleter?.future;
      } else {
        _isRefreshingToken = true;
        _refreshCompleter = Completer();

        try {
          String? refreshToken = await SPref.instance.getJarvisRefreshToken();
          if (refreshToken == null || refreshToken.isEmpty) {
            return null;
          }

          final response = await refreshJarvisAccessToken(refreshToken);
          if (response.statusCode == 200) {
            final newAccessToken = response.data['token']['accessToken'];
            await SPref.instance.setJarvisAccessToken(newAccessToken);

            _refreshCompleter?.complete(newAccessToken);
            return newAccessToken;
          } else {
            throw Exception('Failed to refresh token');
          }
        } catch (e) {
          _refreshCompleter?.completeError(e);
          rethrow;
        } finally {
          _isRefreshingToken = false;
          _refreshCompleter = null;
        }
      }
    }

    return accessToken;
  }

  Future<Response> refreshJarvisAccessToken(String refreshToken) async {
    final response = await _dio.get(
      '$baseUrl/auth/refresh',
      queryParameters: {'refreshToken': refreshToken},
    );
    return response;
  }

  Dio get dio => _dio;
}

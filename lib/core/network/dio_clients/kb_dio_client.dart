import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/storage/spref/spref.dart';

final String baseUrl = dotenv.env['API_URL_KB'] ?? 'http://localhost:3000';

final JarvisDioClient jarvisDioClient = locator<JarvisDioClient>();

class KBDioClient {
  final Dio _externalDio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 6000),
      receiveTimeout: const Duration(seconds: 6000),
      responseType: ResponseType.json,
      contentType: 'application/json',
      validateStatus: (status) => status != 401,
    ),
  );

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

  KBDioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await getKBAccessToken();

        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 && !_isRetrying) {
          _isRetrying = true;

          try {
            final newAccessToken = await getKBAccessToken(forceRefresh: false);

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

  Future<String?> getKBAccessToken({bool forceRefresh = false}) async {
    /// Get access token from shared preferences
    String? accessToken = await SPref.instance.getKBAccessToken();
    String? refreshToken = await SPref.instance.getKBRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      print('refreshToken is null or empty');

      final jarvisAccessToken = await jarvisDioClient.getJarvisAccessToken();

      print('jarvisAccessToken: $jarvisAccessToken');

      final responseExternalLogin = await _externalDio.post(
        '$baseUrl/auth/external-sign-in',
        data: {
          'token': jarvisAccessToken,
        },
      );

      print('responseExternalLogin: ${responseExternalLogin.data}');

      if (responseExternalLogin.statusCode == 200) {
        final newKBAccessToken =
            responseExternalLogin.data['token']['accessToken'];
        final newKBRefreshToken =
            responseExternalLogin.data['token']['refreshToken'];

        // Save access token to shared preferences
        await SPref.instance.setKBAccessToken(newKBAccessToken);
        await SPref.instance.setKBRefreshToken(newKBRefreshToken);

        print('newKBAccessToken: $newKBAccessToken');
        print('newKBRefreshToken: $newKBRefreshToken');

        return newKBAccessToken;
      } else {
        throw Exception('Failed to get access token');
      }
    }

    /// If access token is null or empty, refresh token
    if (forceRefresh || accessToken == null || accessToken.isEmpty) {
      if (_isRefreshingToken) {
        return _refreshCompleter?.future;
      } else {
        _isRefreshingToken = true;
        _refreshCompleter = Completer();

        try {
          /// If access token is null or empty, refresh token
          String? refreshToken = await SPref.instance.getKBRefreshToken();

          /// Get access token from shared preferences
          if (refreshToken == null || refreshToken.isEmpty) {
            return null;
          }

          final response = await refreshKBAccessToken(refreshToken);
          if (response.statusCode == 200) {
            final newAccessToken = response.data['token']['accessToken'];
            await SPref.instance.setKBAccessToken(newAccessToken);

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

  Future<Response> refreshKBAccessToken(String refreshToken) async {
    final response = await _dio.get(
      '$baseUrl/auth/refresh',
      queryParameters: {'refreshToken': refreshToken},
    );
    return response;
  }

  Dio get dio => _dio;
}

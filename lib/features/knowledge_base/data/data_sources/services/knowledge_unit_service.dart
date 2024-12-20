// Vị trí: lib/features/knowledge/data/services/knowledge_unit_service.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class KnowledgeUnitService {
  //final Dio dio = locator<DioClient>().dio;
  final Dio dio = Dio(BaseOptions(
    connectTimeout: Duration(minutes: 10),
    sendTimeout: Duration(minutes: 10),
    receiveTimeout: Duration(minutes: 10),
  ));

  /// Upload a local file as a Knowledge Unit
  ///
  /// [id] - ID of the Knowledge resource.
  /// [filePath] - Path to the local file to upload.
  /// [token] - Authentication token.
  Future<Response> uploadLocalFileUnit({
    required String id,
    required String filePath,
    required String token,
  }) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception("File does not exist: $filePath");
      }

      final mimeType = lookupMimeType(filePath);
      if (mimeType == null) {
        throw Exception("Cannot determine mime type of file: $filePath");
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: file.uri.pathSegments.last,
          contentType: MediaType.parse(mimeType),
        ),
      });

      final response = await dio.post(
        'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/local-file',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print("Response: ${response.data}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Upload website content as a Knowledge Unit
  ///
  /// [id] - ID of the Knowledge resource.
  /// [unitName] - Name of the Knowledge Unit.
  /// [webUrl] - URL of the website to fetch content from.
  /// [token] - Authentication token.
  Future<Response> uploadWebsiteContentUnit({
    required String id,
    required String unitName,
    required String webUrl,
    required String token,
  }) async {
    final requestData = {
      'unitName': unitName,
      'webUrl': webUrl,
    };

    final response = await dio.post(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/web',
      data: requestData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response;
  }

  /// Upload Slack content as a Knowledge Unit
  ///
  /// [id] - ID of the Knowledge resource.
  /// [unitName] - Name of the Knowledge Unit.
  /// [slackWorkspace] - Slack workspace identifier.
  /// [slackBotToken] - Slack bot token.
  /// [token] - Authentication token.
  Future<Response> uploadSlackContentUnit({
    required String id,
    required String unitName,
    required String slackWorkspace,
    required String slackBotToken,
    required String token,
  }) async {
    final requestData = {
      'unitName': unitName,
      'slackWorkspace': slackWorkspace,
      'slackBotToken': slackBotToken,
    };

    final response = await dio.post(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/slack',
      data: requestData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response;
  }

  /// Upload Confluence content as a Knowledge Unit
  ///
  /// [id] - ID of the Knowledge resource.
  /// [unitName] - Name of the Knowledge Unit.
  /// [wikiPageUrl] - URL of the Confluence wiki page.
  /// [confluenceUsername] - Confluence username.
  /// [confluenceAccessToken] - Confluence access token.
  /// [token] - Authentication token.
  Future<Response> uploadConfluenceContentUnit({
    required String id,
    required String unitName,
    required String wikiPageUrl,
    required String confluenceUsername,
    required String confluenceAccessToken,
    required String token,
  }) async {
    final requestData = {
      'unitName': unitName,
      'wikiPageUrl': wikiPageUrl,
      'confluenceUsername': confluenceUsername,
      'confluenceAccessToken': confluenceAccessToken,
    };

    final response = await dio.post(
      'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/confluence',
      data: requestData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    return response;
  }
}

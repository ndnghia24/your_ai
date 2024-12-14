// Vị trí: lib/features/knowledge/data/services/knowledge_unit_service.dart

import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';

class KnowledgeUnitService {
  //final Dio dio = locator<DioClient>().dio;
  final Dio dio = Dio();

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
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });

    print(formData.files.first.value.filename);
    print(
        'https://knowledge-api.jarvis.cx/kb-core/v1/knowledge/$id/local-file');
    print('Bearer $token');

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
    print("response " + response.data);
    return response;
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
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/storage/spref/spref.dart';
import 'package:your_ai/configs/service_locator.dart';

final String? baseUrl = dotenv.env['API_URL'];

class EmailResponseService {
  String? accessToken;
  final Dio _dio = locator<JarvisDioClient>().dio;

  EmailResponseService._privateConstructor() {
    _initializeTokens();
  }

  static final EmailResponseService _instance =
      EmailResponseService._privateConstructor();

  factory EmailResponseService() {
    return _instance;
  }

  Future<void> _initializeTokens() async {
    accessToken = await SPref.instance.getJarvisAccessToken();
  }

  /// Gửi request để lấy các ý tưởng phản hồi email
  Future<Response> getEmailReplyIdeas(Map<String, dynamic> body) async {
    try {
      return await _dio.post(
        '$baseUrl/api/v1/ai-email/reply-ideas',
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Gửi request để tạo phản hồi dựa trên ý tưởng chính
  Future<Response> getReplyByIdea(Map<String, dynamic> body) async {
    try {
      return await _dio.post(
        '$baseUrl/api/v1/ai-email',
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } catch (e) {
      rethrow;
    }
  }
}

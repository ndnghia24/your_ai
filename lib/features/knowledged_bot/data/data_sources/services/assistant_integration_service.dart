import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';

class AssistantIntegrationService {
  final Dio dio = locator<KBDioClient>().dio;

  AssistantIntegrationService();

  // Get Configurations
  Future<Response> getConfigurations(String assistantId) async {
    try {
      final response = await dio.get(
        '/kb-core/v1/bot-integration/$assistantId/configurations',
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get configurations: $e');
    }
  }

  // Disconnect Bot Integration
  Future<Response> disconnectIntegration(
      String assistantId, String type) async {
    try {
      final response = await dio.delete(
        '/kb-core/v1/bot-integration/$assistantId/$type',
      );
      return response;
    } catch (e) {
      throw Exception('Failed to disconnect integration: $e');
    }
  }

  // Verify Telegram Bot Configure
  Future<Response> verifyTelegramConfig(String botToken) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/telegram/validation',
        data: {
          'botToken': botToken,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to verify Telegram bot configuration: $e');
    }
  }

  // Publish Telegram Bot
  Future<Response> publishTelegramBot(
      String assistantId, String botToken) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/telegram/publish/$assistantId',
        data: {
          'botToken': botToken,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to publish Telegram bot: $e');
    }
  }

  // Verify Slack Bot Configure
  Future<Response> verifySlackConfig(String botToken, String clientId,
      String clientSecret, String signingSecret) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/slack/validation',
        data: {
          'botToken': botToken,
          'clientId': clientId,
          'clientSecret': clientSecret,
          'signingSecret': signingSecret,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to verify Slack bot configuration: $e');
    }
  }

  // Publish Slack Bot
  Future<Response> publishSlackBot(String assistantId, String botToken,
      String clientId, String clientSecret, String signingSecret) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/slack/publish/$assistantId',
        data: {
          'botToken': botToken,
          'clientId': clientId,
          'clientSecret': clientSecret,
          'signingSecret': signingSecret,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to publish Slack bot: $e');
    }
  }

  // Verify Messenger Bot Configure
  Future<Response> verifyMessengerConfig(
      String botToken, String pageId, String appSecret) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/messenger/validation',
        data: {
          'botToken': botToken,
          'pageId': pageId,
          'appSecret': appSecret,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to verify Messenger bot configuration: $e');
    }
  }

  // Publish Messenger Bot
  Future<Response> publishMessengerBot(String assistantId, String botToken,
      String pageId, String appSecret) async {
    try {
      final response = await dio.post(
        '/kb-core/v1/bot-integration/messenger/publish/$assistantId',
        data: {
          'botToken': botToken,
          'pageId': pageId,
          'appSecret': appSecret,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to publish Messenger bot: $e');
    }
  }
}

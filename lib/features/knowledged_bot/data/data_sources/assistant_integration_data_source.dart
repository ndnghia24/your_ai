import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_integration_service.dart';

class AssistantIntegrationRemoteDataSource {
  final AssistantIntegrationService _assistantIntegrationService;
  AssistantIntegrationRemoteDataSource(this._assistantIntegrationService);

  Future<DataSourcesResultTemplate> getConfigurations(
      String assistantId) async {
    try {
      final response =
          await _assistantIntegrationService.getConfigurations(assistantId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Configurations fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while fetching configurations',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> disconnectBotIntegration(
      String assistantId, String type) async {
    try {
      final response = await _assistantIntegrationService.disconnectIntegration(
          assistantId, type);

      if (response.statusCode == 204) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: null,
          message: 'Bot integration disconnected successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while disconnecting bot integration',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> verifyTelegramBotConfigure(
      String botToken) async {
    try {
      final response =
          await _assistantIntegrationService.verifyTelegramConfig(botToken);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Telegram bot configuration verified successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while verifying Telegram bot configuration',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> publishTelegramBot(
      String assistantId, String botToken) async {
    try {
      final response = await _assistantIntegrationService.publishTelegramBot(
          assistantId, botToken);

      if (response.statusCode == 201) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Telegram bot published successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while publishing Telegram bot',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> verifySlackBotConfigure(String botToken,
      String clientId, String clientSecret, String signingSecret) async {
    try {
      final response = await _assistantIntegrationService.verifySlackConfig(
          botToken, clientId, clientSecret, signingSecret);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Slack bot configuration verified successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while verifying Slack bot configuration',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> publishSlackBot(
      String assistantId,
      String botToken,
      String clientId,
      String clientSecret,
      String signingSecret) async {
    try {
      final response = await _assistantIntegrationService.publishSlackBot(
          assistantId, botToken, clientId, clientSecret, signingSecret);

      if (response.statusCode == 201) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Slack bot published successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while publishing Slack bot',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> verifyMessengerBotConfigure(
      String botToken, String pageId, String appSecret) async {
    try {
      final response = await _assistantIntegrationService.verifyMessengerConfig(
          botToken, pageId, appSecret);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Messenger bot configuration verified successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while verifying Messenger bot configuration',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> publishMessengerBot(String assistantId,
      String botToken, String pageId, String appSecret) async {
    try {
      final response = await _assistantIntegrationService.publishMessengerBot(
          assistantId, botToken, pageId, appSecret);

      if (response.statusCode == 201) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Messenger bot published successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred while publishing Messenger bot',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}

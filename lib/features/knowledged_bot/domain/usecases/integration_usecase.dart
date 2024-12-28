import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';

class GetIntegrationConfigurationsUseCase {
  final AssistantRepository _repository;

  GetIntegrationConfigurationsUseCase(this._repository);

  Future<UsecaseResultTemplate<List<dynamic>>> execute({
    required String assistantId,
  }) async {
    try {
      final configurations =
          await _repository.integration.getConfigurations(assistantId);

      return UsecaseResultTemplate<List<dynamic>>(
        isSuccess: true,
        result: configurations,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<String>>(
        isSuccess: false,
        result: [],
        message: e.toString(),
      );
    }
  }
}

class DisconnectIntegrationUseCase {
  final AssistantRepository _repository;

  DisconnectIntegrationUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute({
    required String assistantId,
    required String type,
  }) async {
    try {
      await _repository.integration.disconnectIntegration(assistantId, type);

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Integration disconnected successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

class VerifyTelegramConfigUseCase {
  final AssistantRepository _repository;

  VerifyTelegramConfigUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute(
      {required String botToken}) async {
    try {
      await _repository.integration.verifyTelegramConfig(botToken);

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Telegram bot configuration verified',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

class PublishTelegramBotUseCase {
  final AssistantRepository _repository;

  PublishTelegramBotUseCase(this._repository);

  Future<UsecaseResultTemplate<String>> execute({
    required String assistantId,
    required String botToken,
  }) async {
    try {
      var result = await _repository.integration.publishTelegramBot(assistantId, botToken);

      return UsecaseResultTemplate<String>(
        isSuccess: true,
        result: result['redirect'],
        message: 'Telegram bot published successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<String>(
        isSuccess: false,
        result: '',
        message: e.toString(),
      );
    }
  }
}

class VerifySlackConfigUseCase {
  final AssistantRepository _repository;

  VerifySlackConfigUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute({
    required String botToken,
    required String clientId,
    required String clientSecret,
    required String signingSecret,
  }) async {
    try {
      await _repository.integration.verifySlackConfig(
        botToken,
        clientId,
        clientSecret,
        signingSecret,
      );

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Slack bot configuration verified',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

class PublishSlackBotUseCase {
  final AssistantRepository _repository;

  PublishSlackBotUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute({
    required String assistantId,
    required String botToken,
    required String clientId,
    required String clientSecret,
    required String signingSecret,
  }) async {
    try {
      await _repository.integration.publishSlackBot(
        assistantId,
        botToken,
        clientId,
        clientSecret,
        signingSecret,
      );

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Slack bot published successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

class VerifyMessengerConfigUseCase {
  final AssistantRepository _repository;

  VerifyMessengerConfigUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute({
    required String botToken,
    required String pageId,
    required String appSecret,
  }) async {
    try {
      await _repository.integration.verifyMessengerConfig(
        botToken,
        pageId,
        appSecret,
      );

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Messenger bot configuration verified',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

class PublishMessengerBotUseCase {
  final AssistantRepository _repository;

  PublishMessengerBotUseCase(this._repository);

  Future<UsecaseResultTemplate<void>> execute({
    required String assistantId,
    required String botToken,
    required String pageId,
    required String appSecret,
  }) async {
    try {
      await _repository.integration.publishMessengerBot(
        assistantId,
        botToken,
        pageId,
        appSecret,
      );

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Messenger bot published successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: e.toString(),
      );
    }
  }
}

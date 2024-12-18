import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';

class GetThreadsUseCase {
  final AssistantRepository _repository;

  GetThreadsUseCase(this._repository);

  Future<UsecaseResultTemplate<List<Thread>>> execute(
      String assistantId) async {
    /*return _repository.chat.getThreads(assistantId);*/
    try {
      final thread = await _repository.chat.getThreads(assistantId);

      return UsecaseResultTemplate<List<Thread>>(
        isSuccess: true,
        result: thread,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<List<Thread>>(
        isSuccess: false,
        result: [],
        message: e.toString(),
      );
    }
  }
}

class GetThreadDetailsUseCase {
  final AssistantRepository _repository;

  GetThreadDetailsUseCase(this._repository);

  Future<UsecaseResultTemplate<Thread>> execute(String openAiThreadId) async {
    /*return _repository.chat.getThreadDetails(openAiThreadId);*/

    try {
      final thread = await _repository.chat.getThreadDetails(openAiThreadId);

      return UsecaseResultTemplate<Thread>(
        isSuccess: true,
        result: thread,
        message: 'Success',
      );
    } catch (e) {
      return UsecaseResultTemplate<Thread>(
        isSuccess: false,
        result: Thread.initial(),
        message: e.toString(),
      );
    }
  }
}

class ContinueChatUseCase {
  final AssistantRepository _repository;

  ContinueChatUseCase(this._repository);

  Future<UsecaseResultTemplate<String>> execute(
      String assistantId, String message, String openAiThreadId,
      {String additionalInstruction = ''}) async {
    /*return _repository.chat.continueChat(
      assistantId,
      message,
      openAiThreadId,
      additionalInstruction: additionalInstruction,
    );*/

    try {
      final result = await _repository.chat.continueChat(
        assistantId,
        message,
        openAiThreadId,
        additionalInstruction: additionalInstruction,
      );

      return UsecaseResultTemplate<String>(
        isSuccess: true,
        result: result,
        message: 'Success',
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

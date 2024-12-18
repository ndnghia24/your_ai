import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_chat_service.dart';

class AssistantChatRemoteDataSource {
  final AssistantChatService _assistantChatService;
  AssistantChatRemoteDataSource(this._assistantChatService);

  Future<DataSourcesResultTemplate> getThreads(String assistantId) async {
    try {
      final response = await _assistantChatService.getThreads(assistantId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Threads fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching threads',
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

  Future<DataSourcesResultTemplate> getThreadDetails(
      String openAiThreadId) async {
    try {
      final response =
          await _assistantChatService.getThreadDetails(openAiThreadId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Thread details fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching thread details',
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

  Future<DataSourcesResultTemplate> continueChat(
      String assistantId, String message, String openAiThreadId,
      {String additionalInstruction = ''}) async {
    try {
      final response = await _assistantChatService.continueChat(
        assistantId,
        message,
        openAiThreadId,
        additionalInstruction: additionalInstruction,
      );

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Message sent successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during sending message',
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

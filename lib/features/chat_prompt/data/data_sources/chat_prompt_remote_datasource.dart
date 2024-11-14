import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/chat_prompt/data/data_sources/services/chat_prompt_service.dart';

class ChatPromptRemoteDataSource {
  final ChatPromptService _chatPromptService;

  const ChatPromptRemoteDataSource(this._chatPromptService);

  Future<DataSourcesResultTemplate> getAllPrompts({
    required Map<String, dynamic> params,
  }) async {
    try {
      final queryParams = {
        if (params['category'] != null) 'category': params['category'],
        if (params['isPublic'] != null) 'isPublic': params['isPublic'],
        if (params['isFavorite'] != null) 'isFavorite': params['isFavorite'],
      };

      final response = await _chatPromptService.getAllPrompts(queryParams);

      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompts fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during fetching prompts',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred during fetching prompts: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> createNewPrompt({
    required String title,
    required String description,
    required String content,
    required String category,
    required String language,
    required bool isPublic,
  }) async {
    try {
      final response = await _chatPromptService.createNewPrompt(
        {
          'title': title,
          'description': description,
          'content': content ?? '',
          'language': language ?? 'English',
          'category': category ?? 'other',
          'isPublic': isPublic ?? true,
        },
      );

      if (response.statusCode == 201) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompt created successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during creating prompt',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred during creating prompt: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> updatePrompt({
    required String promptId,
    required String title,
    required String description,
    required String content,
    required String category,
    required String language,
    required bool isPublic,
  }) async {
    try {
      final response = await _chatPromptService.updatePrompt(
        promptId: promptId,
        body: {
          'title': title,
          'description': description,
          'content': content,
          'language': language,
          'category': category,
          'isPublic': isPublic,
        },
      );

      print('Data: ${response.data}');

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompt updated successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during updating prompt',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred during updating prompt: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> deletePrompt({
    required String promptId,
  }) async {
    try {
      final response =
          await _chatPromptService.deletePrompt(promptId: promptId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompt deleted successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during deleting prompt',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred during deleting prompt: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> addPromptToFavorite({
    required String promptId,
  }) async {
    try {
      final response =
          await _chatPromptService.addPromptToFavorite(promptId: promptId);

      if (response.statusCode == 201) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompt added to favorites',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during adding prompt to favorites',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message:
            'Error occurred during adding prompt to favorites: ${e.toString()}',
      );
    }
  }

  Future<DataSourcesResultTemplate> removePromptFromFavorite({
    required String promptId,
  }) async {
    try {
      final response =
          await _chatPromptService.removePromptFromFavorite(promptId: promptId);

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: 'Prompt removed from favorites',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: 'Error occurred during removing prompt from favorites',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message:
            'Error occurred during removing prompt from favorites: ${e.toString()}',
      );
    }
  }
}

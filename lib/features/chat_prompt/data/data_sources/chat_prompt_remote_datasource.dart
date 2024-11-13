import 'package:your_ai/features/chat_prompt/data/data_sources/services/chat_prompt_service.dart';

class ChatPromptRemoteDataSource {
  final ChatPromptService _chatPromptService;
  const ChatPromptRemoteDataSource(this._chatPromptService);

  Future<Map<String, dynamic>> getAllPrompts({
    required Map<String, dynamic> params,
  }) async {
    try {
      final response = await _chatPromptService.getAllPrompts(
        {
          'category': params['category'] ?? 'other',
          'isPublic': params['isPublic'] ?? true,
          'isFavorite': params['isFavorite'] ?? false,
        },
      );

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompts fetched successfully',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during fetching prompts',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during fetching prompts: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> createNewPrompt({
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
          'content': content,
          'language': language,
          'category': category,
          'isPublic': isPublic,
        },
      );

      if (response.statusCode == 201) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompt created successfully',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during creating prompt',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during creating prompt: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> updatePrompt({
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

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompt updated successfully',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during updating prompt',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during updating prompt: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> deletePrompt({required String promptId}) async {
    try {
      final response =
          await _chatPromptService.deletePrompt(promptId: promptId);

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompt deleted successfully',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during deleting prompt',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during deleting prompt: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> addPromptToFavorite(
      {required String promptId}) async {
    try {
      final response =
          await _chatPromptService.addPromptToFavorite(promptId: promptId);

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompt added to favorites',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during adding prompt to favorites',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message':
            'Error occurred during adding prompt to favorites: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> removePromptFromFavorite(
      {required String promptId}) async {
    try {
      final response =
          await _chatPromptService.removePromptFromFavorite(promptId: promptId);

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Prompt removed from favorites',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during removing prompt from favorites',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message':
            'Error occurred during removing prompt from favorites: ${e.toString()}',
      };
    }
  }
}

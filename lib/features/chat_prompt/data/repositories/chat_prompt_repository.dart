import 'package:your_ai/features/chat_prompt/data/data_sources/chat_prompt_remote_datasource.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class ChatPromptRepository {
  final ChatPromptRemoteDataSource _chatPromptRemoteDataSource;
  const ChatPromptRepository(this._chatPromptRemoteDataSource);

  Future<List<Prompt>> getAllPrompts({
    required Map<String, dynamic> params,
  }) async {
    final res = await _chatPromptRemoteDataSource.getAllPrompts(
      params: params,
    );

    if (res['data'] == null || res['isSuccess'] == false) {
      return [];
    }

    return List<Prompt>.from(res['data'].map((x) => Prompt.fromMap(x)));
  }

  Future<List<Prompt>> getFavouritePrompts() async {
    final res = await _chatPromptRemoteDataSource.getAllPrompts(
      params: {
        'isFavorite': true,
      },
    );

    if (res['data'] == null || res['isSuccess'] == false) {
      return [];
    }

    return List<Prompt>.from(res['data'].map((x) => Prompt.fromMap(x)));
  }

  // Create a new prompt
  Future<Prompt> createNewPrompt({
    required Map<String, dynamic> promptData,
  }) async {
    final res = await _chatPromptRemoteDataSource.createNewPrompt(
      title: promptData['title'],
      description: promptData['description'],
      content: promptData['content'],
      category: promptData['category'] ?? 'other',
      language: promptData['language'] ?? 'English',
      isPublic: promptData['isPublic'] ?? false,
    );

    if (res['data'] == null || res['isSuccess'] == false) {
      throw Exception('Error creating prompt: ${res['message']}');
    }

    return Prompt.fromMap(res['data']);
  }

  Future<Prompt> updatePrompt({
    required String promptId,
    required Map<String, dynamic> promptData,
  }) async {
    final res = await _chatPromptRemoteDataSource.updatePrompt(
      promptId: promptId,
      title: promptData['title'],
      description: promptData['description'],
      content: promptData['content'],
      category: promptData['category'],
      language: promptData['language'],
      isPublic: promptData['isPublic'],
    );

    if (res['data'] == null || res['isSuccess'] == false) {
      throw Exception('Error updating prompt: ${res['message']}');
    }

    return Prompt.fromMap(res['data']);
  }

  Future<void> deletePrompt({required String promptId}) async {
    final res =
        await _chatPromptRemoteDataSource.deletePrompt(promptId: promptId);

    if (res['isSuccess'] == false) {
      throw Exception('Error deleting prompt: ${res['message']}');
    }
  }

  Future<void> addPromptToFavorite({required String promptId}) async {
    final res = await _chatPromptRemoteDataSource.addPromptToFavorite(
        promptId: promptId);

    if (res['isSuccess'] == false) {
      throw Exception('Error adding prompt to favorites: ${res['message']}');
    }
  }

  Future<void> removePromptFromFavorite({required String promptId}) async {
    final res = await _chatPromptRemoteDataSource.removePromptFromFavorite(
        promptId: promptId);

    if (res['isSuccess'] == false) {
      throw Exception(
          'Error removing prompt from favorites: ${res['message']}');
    }
  }
}

import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/usecases/continue_conversation_usecase.dart';
import 'package:your_ai/features/chat_ai/domain/usecases/create_newconversation_usecase.dart';
import 'package:your_ai/features/chat_ai/domain/usecases/get_conversation_detail_usecase.dart';
import 'package:your_ai/features/chat_ai/domain/usecases/get_conversations_usecase.dart';
import 'package:your_ai/features/chat_ai/domain/usecases/get_remaining_query_usecase.dart';

class ChatAIUseCaseFactory {
  final ChatAIRepository chatAIRepository;

  ChatAIUseCaseFactory(this.chatAIRepository);

  CreateNewConversationUseCase get createNewConversationUseCase =>
      CreateNewConversationUseCase(chatAIRepository);
  ContinueConversationUseCase get continueConversationUseCase =>
      ContinueConversationUseCase(chatAIRepository);
  GetConversationsUseCase get getConversationsUseCase =>
      GetConversationsUseCase(chatAIRepository);
  GetConversationDetailUseCase get getConversationDetailUseCase =>
      GetConversationDetailUseCase(chatAIRepository);
  GetRemainingQueryUsecase get getRemainingQueryUsecase =>
      GetRemainingQueryUsecase(chatAIRepository);
}

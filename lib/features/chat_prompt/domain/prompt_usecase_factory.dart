import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/favourite_prompts/add_public_prompt_to_favourite_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/favourite_prompts/get_favourite_public_prompts_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/favourite_prompts/remove_public_prompt_from_favourite_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/private_prompts/create_private_prompt_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/private_prompts/delete_private_prompt_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/private_prompts/get_private_prompts_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/private_prompts/update_private_prompt_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/public_prompts/create_public_prompt_usecase.dart';
import 'package:your_ai/features/chat_prompt/domain/usecases/public_prompts/get_public_prompts_usecase.dart';

class ChatPromptUseCaseFactory {
  final ChatPromptRepository chatPromptRepository;

  ChatPromptUseCaseFactory(this.chatPromptRepository);

  // Private Prompt
  GetPrivatePromptsUsecase get getPrivatePromptsUsecase =>
      GetPrivatePromptsUsecase(chatPromptRepository);
  CreatePrivatePromptUsecase get createPrivatePromptUsecase =>
      CreatePrivatePromptUsecase(chatPromptRepository);
  UpdatePrivatePromptUsecase get updatePrivatePromptUsecase =>
      UpdatePrivatePromptUsecase(chatPromptRepository);
  DeletePrivatePromptUsecase get deletePrivatePromptUsecase =>
      DeletePrivatePromptUsecase(chatPromptRepository);

  // Public Prompt
  CreatePublicPromptUsecase get createPublicPromptUsecase =>
      CreatePublicPromptUsecase(chatPromptRepository);
  GetPublicPromptsUsecase get getPublicPromptsUsecase =>
      GetPublicPromptsUsecase(chatPromptRepository);

  // Favourite Public Prompt
  GetFavouritePromptUsecase get getFavouritePromptUsecase =>
      GetFavouritePromptUsecase(chatPromptRepository);
  AddFavouritePromptUsecase get addFavouritePromptUsecase =>
      AddFavouritePromptUsecase(chatPromptRepository);
  RemoveFavouritePromptUsecase get removeFavouritePromptUsecase =>
      RemoveFavouritePromptUsecase(chatPromptRepository);
}

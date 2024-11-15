import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';

class GetRemainingQueryUsecase {
  final ChatAIRepository chatAIRepository;
  GetRemainingQueryUsecase(this.chatAIRepository);

  Future<UsecaseResultTemplate<int>> execute() async {
    return UsecaseResultTemplate<int>(
      isSuccess: true,
      result: await chatAIRepository.getRemainingQuery(),
      message: 'Remaining query fetched successfully',
    );
  }
}

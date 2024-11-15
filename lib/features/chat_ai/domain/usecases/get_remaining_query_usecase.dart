import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';

class GetRemainingQueryUsecase {
  final ChatAIRepository chatAIRepository;
  GetRemainingQueryUsecase(this.chatAIRepository);

  Future<UsecaseResultTemplate<Map<String, int>>> execute() async {
    return UsecaseResultTemplate<Map<String, int>>(
      isSuccess: true,
      result: {
        'remainingQuery': await chatAIRepository.getRemainingQuery(),
        'totalQuery': chatAIRepository.getTotalQuery,
      },
      message: 'Remaining query fetched successfully',
    );
  }
}

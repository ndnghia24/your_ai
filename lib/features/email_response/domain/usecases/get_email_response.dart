import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/email_response/data/repositories/email_response_repositoriy.dart';

class GetReplyByIdeaUseCase {
  final EmailResponseRepository _emailResponseRepository;

  GetReplyByIdeaUseCase(this._emailResponseRepository);

  Future<UsecaseResultTemplate<String>> execute({
    required String mainIdea,
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final res = await _emailResponseRepository.getReplyByIdea(
        mainIdea: mainIdea,
        action: action,
        email: email,
        metadata: metadata,
      );

      return UsecaseResultTemplate(
        isSuccess: true,
        result: res['email'],
        message: 'Email reply fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate(
        isSuccess: false,
        result: '',
        message: 'Failed to fetch email reply: $e',
      );
    }
  }
}

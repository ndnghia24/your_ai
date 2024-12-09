import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/email_response/data/repositories/email_response_repositoriy.dart';

class GetEmailReplyIdeasUseCase {
  final EmailResponseRepository _emailResponseRepository;

  GetEmailReplyIdeasUseCase(this._emailResponseRepository);

  Future<UsecaseResultTemplate<List<String>>> execute({
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final res = await _emailResponseRepository.getEmailReplyIdeas(
        action: action,
        email: email,
        metadata: metadata,
      );

      return UsecaseResultTemplate(
        isSuccess: true,
        result: res['ideas'],
        message: 'Email reply ideas fetched successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate(
        isSuccess: false,
        result: [],
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}

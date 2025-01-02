import 'package:your_ai/features/email_response/data/repositories/email_response_repositoriy.dart';
import 'package:your_ai/features/email_response/domain/usecases/get_email_response.dart';
import 'package:your_ai/features/email_response/domain/usecases/get_email_response_ideas.dart';

class EmailResponseUseCaseFactory {
  final EmailResponseRepository emailResponseRepository;

  EmailResponseUseCaseFactory(this.emailResponseRepository);

  GetEmailReplyIdeasUseCase get getEmailReplyIdeasUseCase =>
      GetEmailReplyIdeasUseCase(emailResponseRepository);
  GetReplyByIdeaUseCase get getReplyByIdeaUseCase =>
      GetReplyByIdeaUseCase(emailResponseRepository);
}

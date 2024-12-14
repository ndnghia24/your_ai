import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';

class UploadKnowledgeDataSourceUseCase {
  final KnowledgeRepository repository;

  UploadKnowledgeDataSourceUseCase(this.repository);

  // Thực hiện upload Knowledge Unit với các kiểu upload khác nhau
  Future<UsecaseResultTemplate<void>> execute(
      String id, String token, UploadType uploadType,
      {String filePathOrUrl = '', String unitName = '', String webUrl = '', String slackWorkspace = '', String slackBotToken = '', String wikiPageUrl = '', String confluenceUsername = '', String confluenceAccessToken = ''}) async {
    try {
      if (uploadType == UploadType.localFile) {
        await repository.uploadLocalFileUnit(id, filePathOrUrl, token);
      } else if (uploadType == UploadType.websiteContent) {
        await repository.uploadWebsiteContentUnit(id, unitName, webUrl, token);
      } else if (uploadType == UploadType.slackContent) {
        await repository.uploadSlackContentUnit(id, unitName, slackWorkspace, slackBotToken, token);
      } else if (uploadType == UploadType.confluenceContent) {
        await repository.uploadConfluenceContentUnit(id, unitName, wikiPageUrl, confluenceUsername, confluenceAccessToken, token);
      }

      return UsecaseResultTemplate<void>(
        isSuccess: true,
        result: null,
        message: 'Knowledge unit uploaded successfully',
      );
    } catch (e) {
      return UsecaseResultTemplate<void>(
        isSuccess: false,
        result: null,
        message: 'Error uploading knowledge unit: $e',
      );
    }
  }
}
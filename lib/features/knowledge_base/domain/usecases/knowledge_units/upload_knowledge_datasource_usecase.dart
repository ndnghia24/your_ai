// Vị trí: lib/features/knowledge_base/domain/usecases/upload_knowledge_datasource_usecase.dart

import 'package:your_ai/core/templates/usecase_result_template.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';

class UploadKnowledgeDataSourceUseCase {
  final KnowledgeRepository repository;

  UploadKnowledgeDataSourceUseCase(this.repository);

  // Thực hiện upload Knowledge Unit với kiểu upload (localFile hoặc websiteContent)
  Future<UsecaseResultTemplate<void>> execute(
      String id, String filePathOrUrl, String token, UploadType uploadType,
      {String unitName = '', String webUrl = ''}) async {
    try {
      if (uploadType == UploadType.localFile) {
        await repository.uploadLocalFileUnit(id, filePathOrUrl, token);
      } else if (uploadType == UploadType.websiteContent) {
        await repository.uploadWebsiteContentUnit(id, unitName, webUrl, token);
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

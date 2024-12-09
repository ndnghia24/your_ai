// Vị trí: lib/features/knowledge/knowledge_usecase_factory.dart

import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge/create_knowledge_usecase.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge/delete_knowledge_usecase.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge/get_knowledge_list_usecase.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge/get_knowledge_units_usecase.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge/update_knowledge_usecase.dart';
import 'package:your_ai/features/knowledge_base/domain/usecases/knowledge_units/upload_knowledge_datasource_usecase.dart';

class KnowledgeUseCaseFactory {
  final KnowledgeRepository repository;

  KnowledgeUseCaseFactory(this.repository);

  CreateKnowledgeUseCase get createKnowledgeUseCase =>
      CreateKnowledgeUseCase(repository);

  GetKnowledgeListUseCase get getKnowledgeListUseCase =>
      GetKnowledgeListUseCase(repository);

  GetKnowledgeUnitsUseCase get getKnowledgeUnitsUseCase =>
      GetKnowledgeUnitsUseCase(repository);

  UpdateKnowledgeUseCase get updateKnowledgeUseCase =>
      UpdateKnowledgeUseCase(repository);

  DeleteKnowledgeUseCase get deleteKnowledgeUseCase =>
      DeleteKnowledgeUseCase(repository);

  UploadKnowledgeDataSourceUseCase get uploadKnowledgeDataSourceUseCase =>
      UploadKnowledgeDataSourceUseCase(repository);
}

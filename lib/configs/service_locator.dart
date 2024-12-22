import 'package:get_it/get_it.dart';
import 'package:your_ai/core/network/dio_clients/jarvis_dio_client.dart';
import 'package:your_ai/core/network/dio_clients/kb_dio_client.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/auth/data/data_sources/services/auth_services.dart';
import 'package:your_ai/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:your_ai/features/auth/data/repositories/auth_repository.dart';
import 'package:your_ai/features/auth/domain/auth_usecases_factory.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_bloc.dart';

///
import 'package:your_ai/features/chat_ai/data/data_sources/chat_ai_remote_datasource.dart';
import 'package:your_ai/features/chat_ai/data/data_sources/services/chat_ai_service.dart';
import 'package:your_ai/features/chat_ai/data/repositories/chat_ai_repository.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/presentation/blocs/prompt_bloc.dart';

///
import 'package:your_ai/features/chat_prompt/data/data_sources/chat_prompt_remote_datasource.dart';
import 'package:your_ai/features/chat_prompt/data/data_sources/services/chat_prompt_service.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/prompt_usecase_factory.dart';
import 'package:your_ai/features/email_response/data/data_sources/email_response_datasource.dart';
import 'package:your_ai/features/email_response/data/data_sources/services/email_response_service.dart';
import 'package:your_ai/features/email_response/data/repositories/email_response_repositoriy.dart';
import 'package:your_ai/features/email_response/domain/email_usecase_factory.dart';

///
import 'package:your_ai/features/knowledge_base/data/data_sources/knowledge_remote_data_source.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_service.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_unit_service.dart';
import 'package:your_ai/features/knowledge_base/data/repositories/knowledge_repository.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_bloc.dart';

///
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_chat_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/assistant_knowledge_data_source.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_chat_service.dart';
import 'package:your_ai/features/knowledged_bot/data/data_sources/services/assistant_knowledge_service.dart';
import 'package:your_ai/features/knowledged_bot/data/repositories/assistant_repository.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_bloc.dart';

import '../features/knowledged_bot/data/data_sources/services/assistant_service.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton<JarvisDioClient>(() => JarvisDioClient());
  locator.registerLazySingleton<KBDioClient>(() => KBDioClient());

  /// Auth feature dependencies
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(locator<AuthService>()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(locator<AuthRemoteDataSource>()));
  locator.registerLazySingleton<AuthUseCaseFactory>(
      () => AuthUseCaseFactory(locator<AuthRepository>()));
  // Auth Bloc
  locator.registerLazySingleton<AuthBloc>(
      () => AuthBloc(locator<AuthUseCaseFactory>()));

  /// Chat AI feature dependencies
  locator.registerLazySingleton<ChatAIService>(() => ChatAIService());
  locator.registerLazySingleton<ChatAIRemoteDataSource>(
      () => ChatAIRemoteDataSource(locator<ChatAIService>()));
  locator.registerLazySingleton<ChatAIRepository>(
      () => ChatAIRepository(locator<ChatAIRemoteDataSource>()));
  locator.registerLazySingleton<ChatAIUseCaseFactory>(
      () => ChatAIUseCaseFactory(locator<ChatAIRepository>()));

  ///Chat AI Bloc
  locator.registerLazySingleton<ConversationBloc>(
      () => ConversationBloc(locator<ChatAIUseCaseFactory>()));
  locator.registerLazySingleton<ModelBloc>(
      () => ModelBloc()..add(UpdateModel(GenerativeAiModel.gpt4oMini)));

  /// Email Response feature dependencies
  locator.registerLazySingleton<EmailResponseService>(
      () => EmailResponseService());
  locator.registerLazySingleton<EmailResponseRemoteDataSource>(
      () => EmailResponseRemoteDataSource(locator<EmailResponseService>()));
  locator.registerLazySingleton<EmailResponseRepository>(
      () => EmailResponseRepository(locator<EmailResponseRemoteDataSource>()));
  locator.registerLazySingleton<EmailResponseUseCaseFactory>(
      () => EmailResponseUseCaseFactory(locator<EmailResponseRepository>()));

  /// Chat Prompt feature dependencies
  locator.registerLazySingleton<ChatPromptService>(() => ChatPromptService());
  locator.registerLazySingleton<ChatPromptRemoteDataSource>(
      () => ChatPromptRemoteDataSource(locator<ChatPromptService>()));
  locator.registerLazySingleton<ChatPromptRepository>(
      () => ChatPromptRepository(locator<ChatPromptRemoteDataSource>()));
  locator.registerLazySingleton<ChatPromptUseCaseFactory>(
      () => ChatPromptUseCaseFactory(locator<ChatPromptRepository>()));
  locator.registerLazySingleton<ChatPromptBloc>(
      () => ChatPromptBloc(locator<ChatPromptUseCaseFactory>()));

  /// Knowledge Base feature dependencies

  locator.registerLazySingleton<KnowledgeService>(() => KnowledgeService());
  locator.registerLazySingleton<KnowledgeUnitService>(
      () => KnowledgeUnitService());
  locator.registerLazySingleton<KnowledgeRemoteDataSource>(() =>
      KnowledgeRemoteDataSource(
          locator<KnowledgeService>(), locator<KnowledgeUnitService>()));
  locator.registerLazySingleton<KnowledgeRepository>(
      () => KnowledgeRepository(locator<KnowledgeRemoteDataSource>()));
  locator.registerLazySingleton<KnowledgeUseCaseFactory>(
      () => KnowledgeUseCaseFactory(locator<KnowledgeRepository>()));
  locator.registerLazySingleton<KBBloc>(
      () => KBBloc(locator<KnowledgeUseCaseFactory>()));
  locator.registerLazySingleton<UnitBloc>(
      () => UnitBloc(locator<KnowledgeUseCaseFactory>()));

  /// Assistant feature dependencies
  // service
  locator.registerLazySingleton<AssistantService>(() => AssistantService());
  locator.registerLazySingleton<AssistantChatService>(
      () => AssistantChatService());
  locator.registerLazySingleton<AssistantKnowledgeService>(
      () => AssistantKnowledgeService());
  // Datasource
  locator.registerLazySingleton<AssistantRemoteDataSource>(
      () => AssistantRemoteDataSource(locator<AssistantService>()));
  locator.registerLazySingleton<AssistantChatRemoteDataSource>(
      () => AssistantChatRemoteDataSource(locator<AssistantChatService>()));
  locator.registerLazySingleton<AssistantKnowledgeRemoteDataSource>(() =>
      AssistantKnowledgeRemoteDataSource(locator<AssistantKnowledgeService>()));
  // Repository
  locator.registerLazySingleton<AssistantRepository>(() => AssistantRepository(
        locator<AssistantRemoteDataSource>(),
        locator<AssistantKnowledgeRemoteDataSource>(),
        locator<AssistantChatRemoteDataSource>(),
      ));
  // UseCaseFactory
  locator.registerLazySingleton<AssistantUseCaseFactory>(
      () => AssistantUseCaseFactory(locator<AssistantRepository>()));
  // Bloc
  locator.registerLazySingleton<AssistantBloc>(
      () => AssistantBloc(locator<AssistantUseCaseFactory>()));
}

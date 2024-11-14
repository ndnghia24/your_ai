import 'package:get_it/get_it.dart';
import 'package:your_ai/core/network/dio_client.dart';
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

///
import 'package:your_ai/features/chat_prompt/data/data_sources/chat_prompt_remote_datasource.dart';
import 'package:your_ai/features/chat_prompt/data/data_sources/services/chat_prompt_service.dart';
import 'package:your_ai/features/chat_prompt/data/repositories/chat_prompt_repository.dart';
import 'package:your_ai/features/chat_prompt/domain/prompt_usecase_factory.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton<DioClient>(() => DioClient());

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

  /// Chat Prompt feature dependencies
  locator.registerLazySingleton<ChatPromptService>(() => ChatPromptService());
  locator.registerLazySingleton<ChatPromptRemoteDataSource>(
      () => ChatPromptRemoteDataSource(locator<ChatPromptService>()));
  locator.registerLazySingleton<ChatPromptRepository>(
      () => ChatPromptRepository(locator<ChatPromptRemoteDataSource>()));
  locator.registerLazySingleton<ChatPromptUseCaseFactory>(
      () => ChatPromptUseCaseFactory(locator<ChatPromptRepository>()));
}

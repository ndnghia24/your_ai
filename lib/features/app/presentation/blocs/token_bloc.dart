import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/app/presentation/blocs/token_event.dart';
import 'package:your_ai/features/app/presentation/blocs/token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final ChatAIUseCaseFactory chatAIUseCaseFactory;

  TokenBloc(this.chatAIUseCaseFactory) : super(TokenInitial()) {
    on<LoadToken>(_onLoadToken);
  }

  Future<void> _onLoadToken(LoadToken event, Emitter<TokenState> emit) async {
    try {
      final result = await chatAIUseCaseFactory.getRemainingQueryUsecase.execute();
      if (result.isSuccess) {
        emit(TokenLoaded(result.result['remainingQuery'] ?? 0, result.result['totalQuery'] ?? 0));
      } else {
        emit(TokenError(result.message));
      }
    } catch (e) {
      emit(TokenError(e.toString()));
    }
  }
}
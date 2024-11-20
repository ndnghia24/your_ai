import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_event.dart';
import 'package:your_ai/features/app/presentation/components/my_appbar.dart';
import 'package:your_ai/features/app/widgets/chat_input_widget.dart';
import 'package:your_ai/features/app/widgets/new_app_drawer.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/new_chat_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/old_chat_widget.dart';

final getIt = GetIt.instance;

class ChatSessionScreen extends StatelessWidget {
  const ChatSessionScreen({super.key});

  final bool isNewChat = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConversationBloc>(
          create: (context) => getIt<ConversationBloc>(),
        ),
        BlocProvider<TokenBloc>(
          create: (context) =>
              TokenBloc(getIt<ChatAIUseCaseFactory>())..add(LoadToken()),
        ),
        BlocProvider<ModelBloc>(
          create: (context) =>
              getIt<ModelBloc>(),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        drawer: FractionallySizedBox(
          widthFactor: 0.75,
          child: AppDrawerWidget(),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CustomAppBar(),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) => GestureDetector(
                      onHorizontalDragEnd: (details) {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Expanded(
                              child:
                                  isNewChat ? NewChatWidget() : OldChatWidget(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: BlocBuilder<ModelBloc, ModelState>(
                                builder: (context, modelState) {
                                  GenerativeAiModel selectedModel =
                                      GenerativeAiModel.gpt4oMini;
                                  if (modelState is ModelInitial) {
                                    selectedModel = modelState.selectedModel;
                                  }

                                  final assistant =
                                      generativeAiAssistants[selectedModel]!;

                                  return BlocBuilder<ConversationBloc,
                                      ConversationState>(
                                    builder: (context, state) {
                                      return ChatInputWidget(
                                        onSubmitted: (text) {
                                          if (state is ConversationLoaded) {
                                            BlocProvider.of<ConversationBloc>(
                                                    context)
                                                .add(
                                              ContinueConversation(
                                                content: text,
                                                assistant: {
                                                  'id': assistant.id,
                                                  'model': assistant.model,
                                                },
                                                conversation:
                                                    state.conversation.toMap(),
                                              ),
                                            );
                                          } else if (state
                                              is ConversationInitial) {
                                            BlocProvider.of<ConversationBloc>(
                                                    context)
                                                .add(
                                              CreateNewConversation(
                                                content: text,
                                                assistantId: assistant.id,
                                                assistantModel: assistant.model,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

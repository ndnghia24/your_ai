import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_event.dart';
import 'package:your_ai/features/app/presentation/ui/components/my_appbar.dart';
import 'package:your_ai/features/app/presentation/ui/widgets/chat_input_widget.dart';
import 'package:your_ai/features/app/presentation/ui/widgets/new_app_drawer.dart';

import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/assistant_chat_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/assistant_selector_widgte.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/new_chat_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/old_chat_widget.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';

final getIt = GetIt.instance;

class ChatSessionScreen extends StatelessWidget {
  const ChatSessionScreen({super.key});

  final bool isNewChat = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TokenBloc>(
          create: (context) =>
              TokenBloc(getIt<ChatAIUseCaseFactory>())..add(LoadToken()),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.background,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        BlocBuilder<ModelBloc, ModelState>(
                          bloc: GetIt.I<ModelBloc>(),
                          builder: (context, modelState) {
                            GenerativeAiModel selectedModel =
                                GenerativeAiModel.gpt4oMini;
                            Assistant selectedAssistant =
                                Assistant(id: '', name: '', description: '');
                            if (modelState is ModelInitial) {
                              selectedModel = modelState.selectedModel;

                              if (modelState.selectedAssistant != null) {
                                selectedAssistant =
                                    modelState.selectedAssistant!;
                              }
                            }
                            print('Selected assistant: ${selectedAssistant}');
                            if (selectedModel ==
                                GenerativeAiModel.customChatBot) {
                              final modelBloc = GetIt.I<ModelBloc>();

                              return Expanded(
                                child: Column(
                                  children: [
                                    AssistantSelector(
                                      selectedAssistant: selectedAssistant,
                                      onAssistantChanged: (assistant) {
                                        modelBloc.selectedAssistant = assistant;
                                        print('assistant: ${assistant.name}');
                                        modelBloc.add(UpdateModel(
                                            GenerativeAiModel.customChatBot,
                                            selectedAssistant: assistant));
                                      },
                                    ),
                                    Expanded(
                                      child: selectedAssistant.id.isNotEmpty
                                          ? AssistantChatWidget(
                                              assistant: selectedAssistant)
                                          : CircularProgressIndicator(),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Expanded(
                              child:
                                  isNewChat ? NewChatWidget() : OldChatWidget(),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: BlocBuilder<ModelBloc, ModelState>(
                            bloc: GetIt.I<ModelBloc>(),
                            builder: (context, modelState) {
                              GenerativeAiModel selectedModel =
                                  GenerativeAiModel.gpt4oMini;
                              if (modelState is ModelInitial) {
                                selectedModel = modelState.selectedModel;
                              }

                              final assistant =
                                  generativeAiAssistants[selectedModel]!;

                              return selectedModel ==
                                      GenerativeAiModel.customChatBot
                                  ? Container()
                                  : BlocBuilder<ConversationBloc,
                                      ConversationState>(
                                      bloc: GetIt.I<ConversationBloc>(),
                                      builder: (context, state) {
                                        return ChatInputWidget(
                                          onSubmitted: (text) {
                                            if (state is ConversationLoaded) {
                                              GetIt.I<ConversationBloc>().add(
                                                ContinueConversation(
                                                  content: text,
                                                  assistant: {
                                                    'id': assistant.id,
                                                    'model': assistant.model,
                                                  },
                                                  conversation: state
                                                      .conversation
                                                      .toMap(),
                                                ),
                                              );
                                            } else if (state
                                                is ConversationInitial) {
                                              GetIt.I<ConversationBloc>().add(
                                                CreateNewConversation(
                                                  content: text,
                                                  assistantId: assistant.id,
                                                  assistantModel:
                                                      assistant.model,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

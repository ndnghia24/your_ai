import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_event.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'package:your_ai/features/chat_ai/domain/entities/message.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/chat_intro_widget.dart';

class NewChatWidget extends StatelessWidget {
  const NewChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    void scrollToEnd() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      });
    }

    return BlocListener<ConversationBloc, ConversationState>(
      bloc: GetIt.I<ConversationBloc>(),
      listener: (context, state) {
        if (state is ConversationLoaded || (state is ConversationLoading && state.message != '')) {
          scrollToEnd();
        }
        if (state is ConversationLoaded) {
          BlocProvider.of<TokenBloc>(context).add(LoadToken());
        }
      },
      child: BlocBuilder<ConversationBloc, ConversationState>(
        bloc: GetIt.I<ConversationBloc>(),
        builder: (context, state) {
          if (state is ConversationInitial) {
            return const ChatIntroWidget();
          } else if (state is ConversationLoading) {
            return _buildConversationLoading(
                context, state.conversation, state.message, scrollController);
          } else if (state is ConversationLoaded) {
            return _buildConversationContent(
                context, state.conversation, scrollController);
          } else if (state is ConversationError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildConversationContent(BuildContext context,
      Conversation conversation, ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: conversation.messages.length,
      itemBuilder: (context, index) {
        final message = conversation.messages[index];
        final isLastMessage = index == conversation.messages.length - 1;
        return _buildMessage(context, message, isLastMessage);
      },
    );
  }

  Widget _buildConversationLoading(
      BuildContext context,
      Conversation conversation,
      String message,
      ScrollController scrollController) {
    
    return message == "" ? Center(child: CircularProgressIndicator(color: Colors.grey.shade900)) 
     :BlocBuilder<ModelBloc, ModelState>(
      bloc: GetIt.I<ModelBloc>(),
      builder: (context, modelState) {
        GenerativeAiModel selectedModel = GenerativeAiModel.gpt4oMini;
        if (modelState is ModelInitial) {
          selectedModel = modelState.selectedModel;
        }
        GenerativeAiAssistant assistant =
            generativeAiAssistants[selectedModel]!;

        final currentMessage = Message(
            content: message,
            isFromUser: true,
            assistantId: assistant.id,
            assistantModel: assistant.model);
        final loadingMessage = Message(
            content: '...',
            isFromUser: false,
            assistantId: assistant.id,
            assistantModel: assistant.model);
        final updatedMessages = List<Message>.from(conversation.messages)
          ..add(currentMessage)
          ..add(loadingMessage);

        return ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: updatedMessages.length,
          itemBuilder: (context, index) {
            final message = updatedMessages[index];
            final isLastMessage = index == updatedMessages.length - 1;
            return _buildMessage(context, message, isLastMessage);
          },
        );
      },
    );
  }

  Widget _buildMessage(
      BuildContext context, Message message, bool isLastMessage) {
    bool isFromUser = message.isFromUser;
    String content = message.content;
    GenerativeAiAssistant assistant = getAssistantById(message.assistantId) ??
        generativeAiAssistants[GenerativeAiModel.gpt4oMini]!;
    return Column(
      crossAxisAlignment:
          isFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.fromLTRB(
                (isFromUser ? 16 : 0), 0, (isFromUser ? 0 : 16), 0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.surfaceContainer
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isFromUser)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        assistant.icon,
                        SizedBox(width: 8),
                        Text(
                          assistant.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                MarkdownBody(
                  data: content,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isFromUser && isLastMessage && message.content != '...')
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment:
                  isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                CupertinoButton(
                  child: Icon(
                    CupertinoIcons.square_on_square,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 20, // Reduced icon size
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message copied to clipboard')),
                    );
                  },
                ),
                CupertinoButton(
                  child: Icon(
                    CupertinoIcons.refresh,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 20, // Reduced icon size
                  ),
                  onPressed: () {
                    final conversationBloc = GetIt.I<ConversationBloc>();
                    final updatedMessages = List<Message>.from(conversationBloc.currentConversation.messages);
                    final messageContent = updatedMessages[updatedMessages.length - 2].content;
                    if (updatedMessages.length > 1) {
                      updatedMessages.removeRange(updatedMessages.length - 2, updatedMessages.length);
                    }

                    final updatedConversation = Conversation(id: conversationBloc.currentConversation.id, messages: updatedMessages);
                    
                    conversationBloc.add(
                      ContinueConversation(
                        content: messageContent,
                        assistant: {
                          'id': assistant.id,
                          'model': assistant.model,
                        },
                        conversation: updatedConversation.toMap(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

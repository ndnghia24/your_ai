import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation.dart';
import 'package:your_ai/features/chat_ai/domain/entities/message.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/chat_intro_widget.dart';

class NewChatWidget extends StatelessWidget {
  const NewChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        if (state is ConversationInitial) {
          return const ChatIntroWidget();
        } else if (state is ConversationLoading) {
          return _buildConversationLoading(
              context, state.conversation, state.message);
        } else if (state is ConversationLoaded) {
          return _buildConversationContent(context, state.conversation);
        } else if (state is ConversationError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }

  Widget _buildConversationContent(
      BuildContext context, Conversation conversation) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: conversation.messages.length,
      itemBuilder: (context, index) {
        final message = conversation.messages[index];
        return _buildMessage(context, message.content, message.isFromUser);
      },
    );
  }

  Widget _buildConversationLoading(
      BuildContext context, Conversation conversation, String message) {
    final currentMessage = Message(
        content: message,
        isFromUser: true,
        assistantId: '',
        assistantModel: '');
    final loadingMessage = Message(
        content: '...', isFromUser: false, assistantId: '', assistantModel: '');
    final updatedMessages = List<Message>.from(conversation.messages)
      ..add(currentMessage)
      ..add(loadingMessage);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: updatedMessages.length,
      itemBuilder: (context, index) {
        final message = updatedMessages[index];
        return _buildMessage(context, message.content, message.isFromUser);
      },
    );
  }

  Widget _buildMessage(BuildContext context, String message, bool isFromUser) {
    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            (isFromUser ? 16 : 0), 0, (isFromUser ? 0 : 16), 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isFromUser
              ? Theme.of(context).colorScheme.surfaceContainer
              : Theme.of(context).colorScheme.secondary,
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
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'GPT-3.5 Turbo',
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
              data: message,
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
    );
  }
}
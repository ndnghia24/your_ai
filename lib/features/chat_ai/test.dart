import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';

import 'domain/entities/conversation.dart';
import 'domain/entities/conversation_list.dart';

final locator = GetIt.instance;

class TestChatAIScreen extends StatefulWidget {
  const TestChatAIScreen({super.key});

  @override
  _TestChatAIScreenState createState() => _TestChatAIScreenState();
}

class _TestChatAIScreenState extends State<TestChatAIScreen> {
  final ChatAIUseCaseFactory chatAIUseCaseFactory =
      locator<ChatAIUseCaseFactory>();

  ConversationList conversationList = ConversationList(
    conversationsList: [],
    currentConversationId: '',
  );

  Conversation currentConv = Conversation(
    id: '-1',
    messages: [],
  );

  void _updateCurrentConversation(Conversation conversation) {
    setState(() {
      currentConv = conversation;
    });
  }

  void _updateConversationList(ConversationList list) {
    setState(() {
      conversationList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display current conversation and conversation list
              Text('Current Conversation: ${currentConv.toMapString()}'),
              Text('Conversation List: ${conversationList.toMapString()}'),
              const Divider(),

              ElevatedButton(
                onPressed: () async {
                  final usecaseResult = await chatAIUseCaseFactory
                      .createNewConversationUseCase
                      .execute(
                          content: 'Hello Your AI at ${DateTime.now()}',
                          assistantId: 'gpt-4o-mini',
                          assistantModel: 'dify');

                  if (usecaseResult.isSuccess) {
                    _updateCurrentConversation(usecaseResult.result);
                  }

                  Fluttertoast.showToast(
                    msg: currentConv.toMapString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text('Create New Conversation'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final usecaseResult = await chatAIUseCaseFactory
                      .continueConversationUseCase
                      .execute(
                    content:
                        'How many previous messages I sent to you? Only answer "[number] + messages"',
                    assistant: {
                      'id': 'gpt-4o-mini',
                      'model': 'dify',
                    },
                    conversation: currentConv.toMap(),
                  );

                  if (usecaseResult.isSuccess) {
                    _updateCurrentConversation(usecaseResult.result);
                  }

                  Fluttertoast.showToast(
                    msg: currentConv.toMapString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text('Continue Conversation with new message'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final usecaseResult = await chatAIUseCaseFactory
                      .getConversationsUseCase
                      .execute(
                    assistantId: 'gpt-4o-mini',
                    assistantModel: 'dify',
                  );

                  if (usecaseResult.isSuccess) {
                    _updateConversationList(usecaseResult.result);
                  }

                  Fluttertoast.showToast(
                    msg: conversationList.toMapString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text('Get Conversations List'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final usecaseResult = await chatAIUseCaseFactory
                      .getConversationDetailUseCase
                      .execute(
                          conversationId:
                              conversationList.getCurrentConversationId(),
                          params: {
                        'assistantId': 'gpt-4o-mini',
                        'assistantModel': 'dify',
                      });

                  if (usecaseResult.isSuccess) {
                    _updateCurrentConversation(usecaseResult.result);
                  }

                  Fluttertoast.showToast(
                    msg: currentConv.toMapString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text('Get Conversation Details'),
              ),

              ElevatedButton(
                onPressed: () async {
                  final usecaseResult = await chatAIUseCaseFactory
                      .getRemainingQueryUsecase
                      .execute();

                  Fluttertoast.showToast(
                    msg: 'Remaining Query: ${usecaseResult.result}',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text('Get Remaining Query'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

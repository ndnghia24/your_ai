import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/presentation/ui/widgets/chat_input_widget.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/content_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/message_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';

class AssistantChatWidget extends StatefulWidget {
  final Assistant assistant;

  const AssistantChatWidget({Key? key, required this.assistant})
      : super(key: key);

  @override
  _AssistantChatWidgetState createState() => _AssistantChatWidgetState();
}

class _AssistantChatWidgetState extends State<AssistantChatWidget> {
  final ScrollController _scrollController = ScrollController();
  final AssistantUseCaseFactory _assistantUseCaseFactory =
      GetIt.I<AssistantUseCaseFactory>();

  List<Message> _messages = [];
  Thread? _currentThread;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void didUpdateWidget(covariant AssistantChatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Perform actions when the widget is rebuilt
    if (oldWidget.assistant.id != widget.assistant.id) {
      _messages.clear();
      _loadInitialData();
    }
  }

  Future<void> _loadInitialData() async {
    final result = await _assistantUseCaseFactory
        .getThreadsUseCase()
        .execute(assistantId: widget.assistant.id);

    if (result.isSuccess && result.result.isNotEmpty) {
      setState(() {
        _currentThread = result.result.first;
      });

      final threadDetails =
          await _assistantUseCaseFactory.getThreadDetailsUseCase().execute(
                currentThread: _currentThread!,
                openAiThreadId: _currentThread!.openAiThreadId,
              );

      if (threadDetails.isSuccess) {
        setState(() {
          _currentThread = threadDetails.result;
          _messages = _currentThread!.messages.reversed.toList();
          _scrollToEnd();
        });
      }
    } else if (result.isSuccess && result.result.isEmpty) {
      final thread =
          await _assistantUseCaseFactory.createThreadUseCase().execute(
                assistantId: widget.assistant.id,
                threadName: 'Test chat',
              );
      if (thread.isSuccess) {
        setState(() {
          _currentThread = thread.result;
          _messages = _currentThread!.messages.reversed.toList();
          _scrollToEnd();
        });
      }
    }
  }

  Future<void> _sendMessage(String text) async {

    setState(() {
      _messages.add(Message(
        role: 'user',
        content: [
          Content(
            type: 'text',
            text: TextContent(value: text),
          ),
        ],
      ));

      _messages.add(Message(
        role: 'assistant',
        content: [
          Content(
            type: 'text',
            text: TextContent(value: "..."),
          ),
        ],
      ));
      _scrollToEnd();
    });

    final result = await _assistantUseCaseFactory.continueChatUseCase().execute(
          assistantId: widget.assistant.id,
          message: text,
          openAiThreadId: _currentThread!.openAiThreadId,
        );

    if (result.isSuccess) {
      final threadDetails =
          await _assistantUseCaseFactory.getThreadDetailsUseCase().execute(
                currentThread: _currentThread!,
                openAiThreadId: _currentThread!.openAiThreadId,
              );

      if (threadDetails.isSuccess) {
        setState(() {
          _currentThread = threadDetails.result;
          _messages = _currentThread!.messages.reversed.toList();
          _scrollToEnd();
        });
      }
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(
      BuildContext context, Message message, bool isLastMessage) {
    bool isFromUser = message.role == 'user';
    String content = message.content.first.text?.value ?? '';

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
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                          widget.assistant.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                MarkdownBody(
                  data: content,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isFromUser && isLastMessage && content != '...')
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
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _currentThread == null
              ? const Center(child: CircularProgressIndicator())
              : _messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat, size: 50, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'Start a conversation with the assistant\nby typing a message in the input box below.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final isLastMessage = index == _messages.length - 1;
                        return _buildMessage(context, message, isLastMessage);
                      },
                    ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: ChatInputWidget(
            onSubmitted: (text) {
              if (text.trim().isNotEmpty) {
                _sendMessage(text);
              }
            },
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey[100],
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: _messageController,
          //           focusNode: FocusNode(),
          //           decoration: const InputDecoration(
          //             hintText: 'Type a message...',
          //             hintStyle: TextStyle(color: Colors.grey),
          //             border: InputBorder.none,
          //             contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          //           ),
          //           textInputAction: TextInputAction.send,
          //           onSubmitted: (value) {
          //             if (value.trim().isNotEmpty) {
          //               _sendMessage();
          //             }
          //           },
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: () {
          //           if (_messageController.text.trim().isNotEmpty) {
          //             _sendMessage();
          //           }
          //         },
          //         icon: const Icon(Icons.send, color: Colors.blue),
          //         splashRadius: 20,
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}

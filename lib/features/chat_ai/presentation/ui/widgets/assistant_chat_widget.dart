import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/content_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/message_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';

class AssistantChatWidget extends StatefulWidget {
  final Assistant assistant;

  const AssistantChatWidget({Key? key, required this.assistant}) : super(key: key);

  @override
  _AssistantChatWidgetState createState() => _AssistantChatWidgetState();
}

class _AssistantChatWidgetState extends State<AssistantChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AssistantUseCaseFactory _assistantUseCaseFactory = GetIt.I<AssistantUseCaseFactory>();

  List<Message> _messages = [];
  Thread? _currentThread;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
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

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty || _currentThread == null) return;

    // Unfocus the keyboard
    FocusScope.of(context).unfocus();

    final messageText = _messageController.text;
    _messageController.clear();

    setState(() {
      _messages.add(Message(
        role: 'user',
        content: [
          Content(
            type: 'text',
            text: TextContent(value: messageText),
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
          message: messageText,
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

  Widget _buildMessage(BuildContext context, Message message, bool isLastMessage) {
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
                  ? Theme.of(context).colorScheme.surface
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
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Assistant',
                          style: TextStyle(
                            color: Colors.white,
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
                      color: isFromUser
                          ? Colors.black
                          : Colors.white,
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
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message copied to clipboard')),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    _sendMessage();
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
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _buildMessage(context, message, isLastMessage),
                        );
                      },
                    ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: FocusNode(),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        _sendMessage();
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      _sendMessage();
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.blue),
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/content_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/message_model.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/assistant_setting_popup.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/publish_bot_screen.dart';

class ChatBotPreviewScreen extends StatefulWidget {
  final Assistant assistant;
  const ChatBotPreviewScreen({super.key, required this.assistant});

  @override
  _ChatBotPreviewScreenState createState() => _ChatBotPreviewScreenState();
}

class _ChatBotPreviewScreenState extends State<ChatBotPreviewScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AssistantUseCaseFactory _assistantUseCaseFactory =
      GetIt.I<AssistantUseCaseFactory>();
// Hard code assistantId
  List<Message> _messages = [];
  Thread? _currentThread;
  String instructions = '';

  @override
  void initState() {
    super.initState();
    instructions = widget.assistant.instructions;
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
      print('Thread: ${thread.result.openAiThreadId}');
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

  onUpdateInstructions(String newInstructions) {
    setState(() {
      instructions = newInstructions;
    });
  }

  void showKnowledgeBaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AssistantSettingPopup(assistantId: widget.assistant.id, description: widget.assistant.description, assistantName: widget.assistant.name, instructions: instructions, onUpdateInstructions: onUpdateInstructions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.assistant.name,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showKnowledgeBaseDialog(context);
            },
            icon: const Icon(Icons.edit, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              //call publish screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => PublishScreen(assistantId: widget.assistant.id)));
            },
            icon: const Icon(Icons.cloud_upload, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preview chat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _currentThread == null
                          ? const Center(child: CircularProgressIndicator())
                          : _messages.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.chat,
                                          size: 50, color: Colors.grey),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Start a conversation with the assistant\nby typing a message in the input box below.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: _messages.length,
                                  itemBuilder: (context, index) {
                                    final message = _messages[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            message.role == 'user'
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message.role == 'user'
                                                ? 'You'
                                                : 'Assistant',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: message.role == 'user'
                                                  ? Colors.grey[300]
                                                  : Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              message.content.first.text
                                                      ?.value ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      textInputAction: TextInputAction
                          .send, // Hiển thị nút gửi trên bàn phím
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _sendMessage(); // Gọi hàm gửi khi nhấn Enter
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageController.text.trim().isNotEmpty) {
                        _sendMessage(); // Gọi hàm gửi khi nhấn nút gửi
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
      ),
    );
  }
}

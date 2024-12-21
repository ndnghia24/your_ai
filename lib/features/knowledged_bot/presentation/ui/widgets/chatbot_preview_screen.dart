import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/thread_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/popup_add_knowledgebase.dart';

class ChatBotPreviewScreen extends StatefulWidget {
  const ChatBotPreviewScreen({super.key});

  @override
  _ChatBotPreviewScreenState createState() => _ChatBotPreviewScreenState();
}

class _ChatBotPreviewScreenState extends State<ChatBotPreviewScreen> {
  final TextEditingController _messageController = TextEditingController();
  final AssistantUseCaseFactory _assistantUseCaseFactory = GetIt.I<AssistantUseCaseFactory>();
  final String _assistantId = 'hardcoded-assistant-id'; // Hard code assistantId
  Thread? _currentThread;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final result = await _assistantUseCaseFactory.getThreadsUseCase().execute(assistantId: _assistantId);
    if (result.isSuccess && result.result.isNotEmpty) {
      setState(() {
        _currentThread = result.result.first;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty || _currentThread == null) return;

    final result = await _assistantUseCaseFactory.continueChatUseCase().execute(
      assistantId: _assistantId,
      message: _messageController.text,
      openAiThreadId: _currentThread!.openAiThreadId,
    );

    if (result.isSuccess) {
      final threadDetails = await _assistantUseCaseFactory.getThreadDetailsUseCase().execute(
        currentThread: _currentThread!,
        openAiThreadId: _currentThread!.openAiThreadId,
      );

      if (threadDetails.isSuccess) {
        setState(() {
          _currentThread = threadDetails.result;
          _messageController.clear();
        });
      }
    }
  }

  void showKnowledgeBaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return KnowledgeBasePopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        elevation: 0, // Loại bỏ shadow của AppBar
        title: Text(
          'Test chat bot',
          style: TextStyle(color: Colors.black), // Đổi màu text thành đen
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add edit action here
              showKnowledgeBaseDialog(context);
            },
            icon: Icon(Icons.edit, color: Colors.black), // Đổi icon thành đen
          ),
        ],
      ),
      body: Column(
        children: [
          // Develop section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Develop',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black), // Màu text đen
                ),
                SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200], // Nền xám nhạt
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Persona & Prompt',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300], // Nền ô nhập liệu
                          hintText: 'Enter your prompt...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),

          // Preview section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preview',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Text màu đen
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Nền trắng nhạt hơn
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _currentThread == null
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: _currentThread!.messages.length,
                              itemBuilder: (context, index) {
                                final message = _currentThread!.messages[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.role == 'user' ? 'You' : 'Assistant',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: message.role == 'user'
                                              ? Colors.grey[300]
                                              : Colors.blue[100],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          message.content.first.text?.value ?? '',
                                          style: TextStyle(color: Colors.black),
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

          // Input section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300], // Nền ô nhập liệu
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
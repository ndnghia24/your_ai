import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_bot/presentation/widgets/popup_add_knowledgebase.dart';

class ChatBotPreviewScreen extends StatelessWidget {
  const ChatBotPreviewScreen({super.key});

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
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .grey[300], // Màu nền tin nhắn xám nhạt
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'What the file 21120303.txt contain?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Assistant',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[
                                        100], // Màu nền tin nhắn từ Assistant
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'The file 21120303.txt contains a link to a video that demonstrates the completion of 24 levels of Flexbox Froggy.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                  onPressed: () {
                    // Send message action
                  },
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

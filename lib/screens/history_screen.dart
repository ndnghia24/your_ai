import 'package:flutter/material.dart';



class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat History',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChatItem(
                  title: 'Assistance Inquiry',
                  message: 'Hei! Kuinka voin auttaa sinua tänään?',
                  time: '09:00',
                ),
                _buildChatItem(
                  title: 'Redimensionnez vos fichiers...',
                  message: 'L\'OCR de cette image indique...',
                  time: '08:20',
                ),
                _buildChatItem(
                  title: 'Assistance Inquiry',
                  message: 'Hei! Kuinka voin auttaa sinua tänään?',
                  time: '17 Sep',
                ),
                _buildChatItem(
                  title: 'Assistance Inquiry',
                  message: 'Hei! Kuinka voin auttaa sinua tänään?',
                  time: '23 Aug',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildChatItem({required String title, required String message, required String time}) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(message),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(time, style: const TextStyle(color: Colors.grey)),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    ),
    onTap: () {
      // Handle chat item tap
    },
  );
}
}
import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/shared/input_widget.dart';

import '../helper/CustomTextStyles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat History',
          style: TextStyle(
            color: Colors.black,
            fontSize: CustomTextStyles.headlineLarge.fontSize,
          ),
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
            child: InputWidget(
                hintText: "Search", leftIconWidget: Icon(Icons.search)),
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

  Widget _buildChatItem(
      {required String title, required String message, required String time}) {
    return Column(
      children: [
        ListTile(
          title: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: CustomTextStyles.headlineMedium.fontSize)),
          subtitle: Text(message,
              style: TextStyle(fontSize: CustomTextStyles.bodyLarge.fontSize)),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(time,
                  style:
                      TextStyle(fontSize: CustomTextStyles.bodyLarge.fontSize)),
              Expanded(
                child: Text("···",
                    style:
                        TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          onTap: () {
            // Handle chat item tap
          },
        ),
        const Divider(indent: 16, endIndent: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/copy_field.dart';

class TelegramConfigurePopup extends StatefulWidget {
  final String assistantId; // Add assistantId parameter
  final String token;
  final isVerified;
  final void Function(String token) onConnect;

  const TelegramConfigurePopup({Key? key, required this.assistantId, required this.onConnect, required this.token,
  required this.isVerified})
      : super(key: key);

  @override
  _TelegramConfigurePopupState createState() => _TelegramConfigurePopupState();
}

class _TelegramConfigurePopupState extends State<TelegramConfigurePopup> {
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tokenController.text = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Configure Telegram Bot',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect to Telegram Bots and chat with this bot in Telegram App',
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Telegram Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  labelText: 'Token',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child:  Text('Cancel', style: TextStyle(color: Colors.black)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onConnect(_tokenController.text);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:widget.isVerified ? Colors.red : Colors.blue,
                    ),
                    child:  Text(widget.isVerified ? 'Disconnect' : 'OK', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
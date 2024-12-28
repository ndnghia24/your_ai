import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/copy_field.dart';

class MessengerConfigurePopup extends StatelessWidget {
  final String assistantId; // Add assistantId parameter

  const MessengerConfigurePopup({Key? key, required this.assistantId})
      : super(key: key);

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
                    'Configure Messenger Bot',
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
                'Connect to Messenger Bots and chat with this bot in Messenger App',
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Messenger Copylink',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                  'Copy the following content to your Messenger app configuration page.'),
              const SizedBox(height: 8),
              CopyField(label: 'Callback URL',
                  value: 'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/$assistantId'), // Use assistantId
              const SizedBox(height: 8),
              CopyField(label: 'Verify Token',value:  'knowledge'),
              const SizedBox(height: 16),
              const Text(
                '2. Messenger Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot Token',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot Page ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot App Secret',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Disconnect'),
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
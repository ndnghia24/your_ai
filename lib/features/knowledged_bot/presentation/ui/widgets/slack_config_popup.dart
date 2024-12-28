import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/copy_field.dart';

class SlackConfigurePopup extends StatelessWidget {
  final String assistantId; // Add assistantId parameter

  const SlackConfigurePopup({Key? key, required this.assistantId})
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
                'Connect to Slack Bots and chat with this bot in Slack App',
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Slack Copylink',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                  'Copy the following content to your Slack app configuration page.'),
              const SizedBox(height: 8),
              CopyField(label: 'OAuth2 Redirect URLs',
                  value: 'hhttps://knowledge-api.jarvis.cx/kb-core/v1/bot-integration/slack/auth/$assistantId'), // Use assistantId
              const SizedBox(height: 8),
              CopyField(label: 'Event Request URL',value:  'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/$assistantId'),
              const SizedBox(height: 8),
              CopyField(label: 'Slash Request URL',value:  'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/slash/$assistantId'),
              const SizedBox(height: 16),
              const Text(
                '2. Slack Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Token',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Client ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Client Secret',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Signing Secret',
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
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('OK'),
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
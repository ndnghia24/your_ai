import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/copy_field.dart';

class SlackConfigurePopup extends StatefulWidget {
  final String assistantId; // Add assistantId parameter
  final String token;
  final String clientId;
  final String clientSecret;
  final String signingSecret;
  final bool isVerified;
  final void Function(String token, String clientId, String clientSecret,
      String signingSecret) onConnect;

  const SlackConfigurePopup({
    Key? key,
    required this.assistantId,
    required this.token,
    required this.clientId,
    required this.clientSecret,
    required this.signingSecret,
    required this.onConnect,
    required this.isVerified,
  }) : super(key: key);

  @override
  State<SlackConfigurePopup> createState() => _SlackConfigurePopupState();
}

class _SlackConfigurePopupState extends State<SlackConfigurePopup> {
  late TextEditingController tokenController;
  late TextEditingController clientIdController;
  late TextEditingController clientSecretController;
  late TextEditingController signingSecretController;

  @override
  void initState() {
    super.initState();
    tokenController = TextEditingController(text: widget.token);
    clientIdController = TextEditingController(text: widget.clientId);
    clientSecretController = TextEditingController(text: widget.clientSecret);
    signingSecretController = TextEditingController(text: widget.signingSecret);
  }

  @override
  void dispose() {
    tokenController.dispose();
    clientIdController.dispose();
    clientSecretController.dispose();
    signingSecretController.dispose();
    super.dispose();
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
                  Expanded(
                    child: const Text(
                      'Configure Slack Bot',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
              CopyField(
                label: 'OAuth2 Redirect URLs',
                value:
                    'https://knowledge-api.jarvis.cx/kb-core/v1/bot-integration/slack/auth/${widget.assistantId}', // Use assistantId
              ),
              const SizedBox(height: 8),
              CopyField(
                label: 'Event Request URL',
                value:
                    'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/${widget.assistantId}',
              ),
              const SizedBox(height: 8),
              CopyField(
                label: 'Slash Request URL',
                value:
                    'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/slash/${widget.assistantId}',
              ),
              const SizedBox(height: 16),
              const Text(
                '2. Slack Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: 'Token',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: clientIdController,
                decoration: const InputDecoration(
                  labelText: 'Client ID',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: clientSecretController,
                decoration: const InputDecoration(
                  labelText: 'Client Secret',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: signingSecretController,
                decoration: const InputDecoration(
                  labelText: 'Signing Secret',
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
                    child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                    ),  
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle save action
                      widget.onConnect(
                        tokenController.text,
                        clientIdController.text,
                        clientSecretController.text,
                        signingSecretController.text,
                      );

                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.isVerified ? Colors.red : Colors.blue,
                    ),
                    child: Text(widget.isVerified ? 'Disconnect' : 'OK', style: TextStyle(color: Colors.white)),
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

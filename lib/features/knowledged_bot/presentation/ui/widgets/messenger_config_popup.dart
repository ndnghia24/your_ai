import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/copy_field.dart';

class MessengerConfigurePopup extends StatefulWidget {
  final String assistantId; // Add assistantId parameter
  final String token;
  final String pageId;
  final String appSecret;
  final isVerified;
  final void Function(String token, String pageId, String appSecret) onConnect;

  const MessengerConfigurePopup({
    Key? key,
    required this.assistantId,
    required this.onConnect,
    required this.token,
    required this.pageId,
    required this.appSecret,
    required this.isVerified,
  }) : super(key: key);

  @override
  State<MessengerConfigurePopup> createState() =>
      _MessengerConfigurePopupState();
}

class _MessengerConfigurePopupState extends State<MessengerConfigurePopup> {
  late TextEditingController tokenController;
  late TextEditingController pageIdController;
  late TextEditingController appSecretController;

  @override
  void initState() {
    super.initState();
    tokenController = TextEditingController(text: widget.token);
    pageIdController = TextEditingController(text: widget.pageId);
    appSecretController = TextEditingController(text: widget.appSecret);
  }

  @override
  void dispose() {
    tokenController.dispose();
    pageIdController.dispose();
    appSecretController.dispose();
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
                      'Configure Messenger Bot',
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
              CopyField(
                label: 'Callback URL',
                value:
                    'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/${widget.assistantId}', // Use assistantId
              ),
              const SizedBox(height: 8),
              const CopyField(label: 'Verify Token', value: 'knowledge'),
              const SizedBox(height: 16),
              const Text(
                '2. Messenger Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot Token',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: pageIdController,
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot Page ID',
                  labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: appSecretController,
                decoration: const InputDecoration(
                  labelText: 'Messenger Bot App Secret',
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
                      widget.onConnect(
                        tokenController.text,
                        pageIdController.text,
                        appSecretController.text,
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

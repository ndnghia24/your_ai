import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PublishScreen extends StatefulWidget {
  final String assistantId; // Add assistantId parameter

  const PublishScreen({Key? key, required this.assistantId}) : super(key: key);

  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  // State variables to manage the checkbox states
  bool isSlackChecked = false;
  bool isTelegramChecked = false;
  bool isMessengerChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish AI Bot'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cloud_upload, color: Colors.white),
            label: const Text(
              'Publish',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Publish to *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'By publishing your bot on the following platforms, you fully understand and agree to abide by Terms of service for each publishing channel.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildPlatformTile(
                    context,
                    platformName: 'Slack',
                    status: 'Not Configured',
                    configureAction: () =>
                        _showConfigurePopup(context, widget.assistantId),
                    isChecked: isSlackChecked,
                    isEnabled: true,
                    onChanged: (value) {
                      setState(() {
                        isSlackChecked = value!;
                      });
                    },
                    icon: CupertinoIcons.chat_bubble,
                  ),
                  _buildPlatformTile(
                    context,
                    platformName: 'Telegram',
                    status: 'Not Configured',
                    configureAction: () =>
                        _showConfigurePopup(context, widget.assistantId),
                    isChecked: isTelegramChecked,
                    isEnabled: true,
                    onChanged: (value) {
                      setState(() {
                        isTelegramChecked = value!;
                      });
                    },
                    icon: CupertinoIcons.paperplane,
                  ),
                  _buildPlatformTile(
                    context,
                    platformName: 'Messenger',
                    status: 'Verified',
                    configureAction: () =>
                        _showConfigurePopup(context, widget.assistantId),
                    isChecked: isMessengerChecked,
                    isEnabled: true,
                    onChanged: (value) {
                      setState(() {
                        isMessengerChecked = value!;
                      });
                    },
                    icon: CupertinoIcons.chat_bubble_2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformTile(BuildContext context,
      {required String platformName,
      required String status,
      required VoidCallback configureAction,
      required bool isChecked,
      required bool isEnabled,
      required ValueChanged<bool?> onChanged,
      required IconData icon}) {
    // Added icon parameter
    return ListTile(
      contentPadding: EdgeInsets.zero, // Remove default padding
      leading: Checkbox(
        value: isChecked,
        onChanged: isEnabled ? onChanged : null,
      ),
      title: Row(
        children: [
          Icon(icon, color: Colors.blue), // Added icon with color
          const SizedBox(width: 8),
          Text(platformName),
        ],
      ),
      subtitle: Text(status),
      trailing: TextButton(
        onPressed: configureAction,
        child: const Text(
          'Configure',
          style:
              TextStyle(color: Colors.blue), // Added color to "Configure" text
        ),
      ),
    );
  }

  void _showConfigurePopup(BuildContext context, String assistantId) {
    showDialog(
      context: context,
      builder: (context) {
        return MessengerConfigurePopup(
            assistantId: assistantId); // Pass assistantId
      },
    );
  }
}

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
              _buildCopyField('Callback URL',
                  'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/$assistantId'), // Use assistantId
              const SizedBox(height: 8),
              _buildCopyField('Verify Token', 'knowledge'),
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

  Widget _buildCopyField(String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: value));
        },
      ),
    );
  }
}

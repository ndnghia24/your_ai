import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/messenger_config_popup.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/publish_config_bot_screent.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/telegram_config_popup.dart';

final getIt = GetIt.instance;
class PublishScreen extends StatefulWidget {
  final String assistantId; // Add assistantId parameter

  const PublishScreen({Key? key, required this.assistantId}) : super(key: key);

  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  bool isSlackChecked = false;
  bool isTelegramChecked = false;
  bool isMessengerChecked = false;
  bool isSlackVerified = false;
  bool isTelegramVerified = false;
  bool isMessengerVerified = false;
  bool isLoading = false;
  String telegramToken = '';
  final AssistantUseCaseFactory assistantUseCaseFactory = GetIt.I<AssistantUseCaseFactory>();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _fetchConfigurations();
  }

  void _fetchConfigurations() {
    assistantUseCaseFactory.getIntegrationConfigurationsUseCase()
        .execute(assistantId: widget.assistantId)
        .then((result) {
      if (result.isSuccess) {
        final configurations = result.result;
        print('Configurations: $configurations');

        // Parse configurations
        _parseConfigurations(configurations);

        setState(() {
          isLoading = false;
        });
      } else {
        print('Error: ${result.message}');
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void _parseConfigurations(List<dynamic> configurations) {
    for (var config in configurations) {
      if (config['type'] == 'slack') {
        isSlackVerified = true;
      } else if (config['type'] == 'telegram') {
        isTelegramVerified = true;
      } else if (config['type'] == 'messenger') {
        isMessengerVerified = true;
      } 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish AI Bot'),
        actions: [
          ElevatedButton.icon(
            onPressed: isLoading ? null : ()=>_publishBot(context),
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
          const SizedBox(width: 8),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                          status: isSlackVerified ,
                          configureAction: () =>
                              _showMessagerConfigurePopup(context, widget.assistantId),
                          isChecked: isSlackChecked,
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
                          status: isTelegramVerified
                              ,
                          configureAction: () =>
                              _showTelegramConfigurePopup(context, widget.assistantId),
                          isChecked: isTelegramChecked,
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
                          status: isMessengerVerified
                             ,
                          configureAction: () =>
                              _showMessagerConfigurePopup(context, widget.assistantId),
                          isChecked: isMessengerChecked,
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

  void _publishBot(BuildContext context) async {
    // Implement the publish bot logic
    String redirectTelegram = '';
    String redirectMessenger = '';
    String redirectSlack = '';
    if(isTelegramChecked){
      final result = await assistantUseCaseFactory.publishTelegramBotUseCase().execute(assistantId: widget.assistantId, botToken: telegramToken);
      if(result.isSuccess){
        redirectTelegram = result.result;
      }
      else{
        print('Error: ${result.message}');
        redirectTelegram = '';
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PublishingPlatformWidget(
        isMessenger: isMessengerChecked,
        isSlack: isSlackChecked,
        isTelegram: isTelegramChecked,
        redirectTelegram: redirectTelegram,
        redirectMessenger: redirectMessenger,
        redirectSlack: redirectSlack,
      ),)
    );


  }


  Widget _buildPlatformTile(BuildContext context,
      {required String platformName,
      required bool status,
      required VoidCallback configureAction,
      required bool isChecked,
      required ValueChanged<bool?> onChanged,
      required IconData icon}) {
    // Added icon parameter
    return ListTile(
      contentPadding: EdgeInsets.zero, // Remove default padding
      leading: Checkbox(
        value: isChecked,
        onChanged: status ? onChanged : null,
      ),
      title: Row(
        children: [
          Icon(icon, color: Colors.blue), // Added icon with color
          const SizedBox(width: 8),
          Text(platformName),
        ],
      ),
      subtitle: Text(status ? 'Verified' : 'Not Configured',
          style: TextStyle(
              color: status ? Colors.green : Colors.red)), // Added color to status text
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

  void _showMessagerConfigurePopup(BuildContext context, String assistantId) {
    showDialog(
      context: context,
      builder: (context) {
        return MessengerConfigurePopup(
            assistantId: assistantId); // Pass assistantId
      },
    );
  }

  void handelConnectTelegram(String token) {
    setState(() {
      isLoading = true;
      telegramToken = token;
    });

    assistantUseCaseFactory.verifyTelegramConfigUseCase()
        .execute(botToken: token)
        .then((result) {
      if (result.isSuccess) {
        print('Telegram connected successfully');
        setState(() {
          isTelegramVerified = true;
          isLoading = false;
        });
      } else {
        print('Error: ${result.message}');
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void _showTelegramConfigurePopup(BuildContext context, String assistantId) {
    showDialog(
      context: context,
      builder: (context) {
        return TelegramConfigurePopup(
            assistantId: assistantId,
            onConnect: handelConnectTelegram,); // Pass assistantId
      },
    );
  }
}



  


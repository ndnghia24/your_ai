import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/redirect_webview.dart';

class PublishingPlatformWidget extends StatelessWidget {
  final bool isMessenger;
  final bool isSlack;
  final bool isTelegram;
  final String redirectMessenger;
  final String redirectSlack;
  final String redirectTelegram;

  const PublishingPlatformWidget({
    Key? key,
    required this.isMessenger,
    required this.isSlack,
    required this.isTelegram,
     this.redirectMessenger = "",
     this.redirectSlack = "",
     this.redirectTelegram = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publishing Platforms"),
        backgroundColor: Colors.blue,
      ),
      body:
          SingleChildScrollView(
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Publishing Platforms",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      _buildPlatformRow(
                        context,
                        icon: Icons.telegram,
                        platformName: "Telegram",
                        status: isTelegram ? "Success" : "Not Configured",
                        actionLabel: isTelegram ? "Open" : "Authorize",
                        redirect: redirectTelegram,
                        statusColor: isTelegram ? Colors.green : Colors.grey,
                      ),
                      const Divider(),
                      _buildPlatformRow(
                        context,
                        icon: Icons.message,
                        platformName: "Messenger",
                        status: isMessenger ? "Success" : "Not Configured",
                        actionLabel: isMessenger ? "Open" : "Authorize",
                        redirect: redirectMessenger,
                        statusColor: isMessenger ? Colors.green : Colors.grey,
                      ),
                      const Divider(),
                      _buildPlatformRow(
                        context,
                        icon: CupertinoIcons.chat_bubble,
                        platformName: "Slack",
                        status: isSlack ? "Success" : "Not Configured",
                        actionLabel: isSlack ? "Open" : "Authorize",
                        redirect: redirectSlack,
                        statusColor: isSlack ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPlatformRow(
    BuildContext context, {
    required IconData icon,
    required String platformName,
    required String status,
    required String actionLabel,
    required String redirect,
    required Color statusColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              platformName,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontSize: 14),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (redirect.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RedirectWebView(
                      title: platformName,
                      url: redirect),
                  ));
                } else {
                  print("Authorizing platform: $platformName");
                }
              },
              child: Text(
                actionLabel,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

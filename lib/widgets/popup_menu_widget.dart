import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black54,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: ModalRoute.of(context)!.animation!,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/google_logo.png'), // Add your logo asset
                          radius: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Jarvis',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildChatItem(
                      label: 'Assistance Inquiry',
                      time: '09:00',
                      isCurrent: true,
                    ),
                    _buildChatItem(
                      label: 'Redimensionnez vo...',
                      time: '08:20',
                    ),
                    _buildChatItem(
                      label: 'Assistance Inquiry',
                      time: '17 Sep',
                    ),
                    _buildChatItem(
                      label: 'Assistance Inquiry',
                      time: '23 Aug',
                    ),
                    const Divider(),
                    _buildMenuOption(Icons.chat_bubble, 'All chats'),
                    _buildMenuOption(Icons.smart_toy, 'Chat bots'),
                    _buildMenuOption(Icons.book, 'Knowledge base'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildChatItem({required String label, required String time, bool isCurrent = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    if (isCurrent) const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Hei! Kuinka voin auttaa sinua tänään?',
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {},
    );
  }
}
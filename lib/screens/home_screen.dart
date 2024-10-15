import 'package:flutter/material.dart';

import '../widgets/popup_menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _showNavigationMenu(context);
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GPT-3.5 Turbo',
              style: TextStyle(color: Colors.black),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.water_drop_outlined, color: Colors.blue),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  '30',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.rocket_launch, color: Colors.blue),
                label: const Text(
                  'Upgrade',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.waving_hand_rounded,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Hi, good afternoon!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "I'm Jarvis, your personal assistant.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Don't know what to say?",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Use a prompt!",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFeatureButton('Grammar corrector'),
            _buildFeatureButton('Essay Improver'),
            _buildFeatureButton('Instagram post Generator'),
            _buildFeatureButton('Pro tips generator'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ask me anything...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  void _showNavigationMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
      return const PopupMenuWidget();
    },
    );
  }
}

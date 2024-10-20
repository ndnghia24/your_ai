import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';
import 'package:jarvis_ai/widgets/shared/chat_input_widget.dart';
import 'package:jarvis_ai/widgets/shared/model_selector_widget.dart';

import '../widgets/app_drawer_widget.dart';
import '../widgets/prompt_library_popup_widget.dart';
import '../widgets/use_prompt_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: FractionallySizedBox(
          widthFactor: 0.75, // Chiều rộng của Drawer là 3/4 chiều rộng màn hình
          child: AppDrawerWidget(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              const HomeBody(),
              const ChatInputWidget(),
            ],
          ),
        ));
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedModel = 'GPT-3.5 Turbo'; // Default selected model

  // Callback function to update the selected model
  void updateSelectedModel(String newModel) {
    setState(() {
      selectedModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          FocusScope.of(context).unfocus();
          Scaffold.of(context).openDrawer();
        },
      ),
      title: ModelSelector(
        selectedModel: selectedModel,
        onModelChanged: updateSelectedModel,
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
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    fontSize: 22, // Increased font size
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "I'm YourAI, your personal assistant.",
              style: TextStyle(fontSize: 20), // Increased font size
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Don't know what to say?",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 18), // Increased font size
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.8, // Chiều cao bằng nửa màn hình
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const PromptLibraryPopupWidget(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Use a prompt!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFeatureButton(context, 'Grammar corrector'),
            _buildFeatureButton(context, 'Essay Improver'),
            _buildFeatureButton(context, 'Instagram post Generator'),
            _buildFeatureButton(context, 'Pro tips generator'),
          ],
        ),
      ),
    );
  }
}

Widget _buildFeatureButton(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const UsePromptWidget(),
        );
      },
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

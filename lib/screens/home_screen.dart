import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';

import '../widgets/popup_menu_widget.dart';
import '../widgets/prompt_library_popup_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        drawer: FractionallySizedBox(
          widthFactor: 0.75, // Chiều rộng của Drawer là 3/4 chiều rộng màn hình
          child: PopupMenuWidget(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              const HomeBody(),
              const CustomChatInput(),
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
      title: ModelDropdown(
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
              "I'm Jarvis, your personal assistant.",
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
            _buildFeatureButton('Grammar corrector'),
            _buildFeatureButton('Essay Improver'),
            _buildFeatureButton('Instagram post Generator'),
            _buildFeatureButton('Pro tips generator'),
          ],
        ),
      ),
    );
  }
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

class CustomChatInput extends StatefulWidget {
  const CustomChatInput({super.key});

  @override
  _CustomChatInputState createState() => _CustomChatInputState();
}

class _CustomChatInputState extends State<CustomChatInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
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
              onPressed: () {
                _focusNode.unfocus();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Dropdown Widget for model selection
class ModelDropdown extends StatelessWidget {
  final String selectedModel;
  final Function(String) onModelChanged;

  ModelDropdown({required this.selectedModel, required this.onModelChanged});

  // List of available models
  final List<String> models = [
    'GPT-3.5 Turbo',
    'GPT-4 Turbo',
    'Claude 3 Haiku',
    'Claude 3 Sonnet',
    'Claude 3 Opus',
    'Gemini 1.0 Pro',
    'Gemini 1.5 Pro',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedModel,
      icon: Icon(Icons.arrow_drop_down),
      isExpanded: true,
      items: models.map((String model) {
        return DropdownMenuItem<String>(
          value: model,
          child: Row(
            children: [
              Icon(
                model.contains('GPT')
                    ? Icons.language
                    : Icons.memory, // Icons based on model type
                color: model.contains('GPT')
                    ? Colors.green
                    : model.contains('Claude')
                        ? Colors.orange
                        : Colors.blue,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  model,
                  overflow: TextOverflow.ellipsis, // Prevent overflow
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onModelChanged(newValue); // Call the callback function
        }
      },
    );
  }
}

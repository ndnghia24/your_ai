import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/shared/input_widget.dart';

import '../helper/CustomColors.dart';

class TestNewPrompt extends StatelessWidget {
  const TestNewPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Center Popup Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const NewPromptPopupWidget(),
            );
          },
          child: const Text('Show Center Popup'),
        ),
      ),
    );
  }
}

class NewPromptPopupWidget extends StatefulWidget {
  const NewPromptPopupWidget({super.key});

  @override
  _NewPromptPopupWidgetState createState() => _NewPromptPopupWidgetState();
}

class _NewPromptPopupWidgetState extends State<NewPromptPopupWidget> {
  bool isPrivatePrompt = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Prompt',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: isPrivatePrompt,
                          onChanged: (bool? value) {
                            setState(() {
                              isPrivatePrompt = value!;
                            });
                          },
                        ),
                        const Text('Private Prompt'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: isPrivatePrompt,
                          onChanged: (bool? value) {
                            setState(() {
                              isPrivatePrompt = value!;
                            });
                          },
                        ),
                        const Text('Public Prompt'),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isPrivatePrompt)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prompt Language',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CustomColors.cardColor,
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8), // Padding bên trong
                          ),
                          value: 'English',
                          items: ['English', 'Spanish', 'French']
                              .map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InputWidget(
                  hintText: "Name of the prompt",
                  leftIconWidget: Container(),
                  minLines: 1),
              const SizedBox(height: 8),
              if (!isPrivatePrompt)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CustomColors.cardColor,
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          value: 'Other',
                          items: ['Other', 'Marketing', 'Chatbot']
                              .map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ],
                ),
              if (!isPrivatePrompt)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputWidget(
                    hintText: "Description",
                    leftIconWidget: Container(),
                  ),
                ),
              const SizedBox(height: 8),
              InputWidget(
                hintText:
                    "Use square brackets [ ] to specify user input. e.g: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]",
                leftIconWidget: Container(),
                minLines: 5,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Create'),
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

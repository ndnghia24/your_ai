import 'package:flutter/material.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Prompt Language',
                      border: OutlineInputBorder(),
                    ),
                    value: 'English',
                    items:
                        ['English', 'Spanish', 'French'].map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name of the prompt',
                  border: OutlineInputBorder(),
                ),
              ),
              if (!isPrivatePrompt)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
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
              if (!isPrivatePrompt)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Description (Optional)',
                      hintText:
                          'Describe your prompt so others can have a better understanding',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Prompt',
                  hintText:
                      'Use square brackets [ ] to specify user input. e.g: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
                  border: OutlineInputBorder(),
                ),
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

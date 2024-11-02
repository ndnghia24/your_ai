import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_ai/chat_session_screen.dart';

class TestUsePromptPopUp extends StatelessWidget {
  const TestUsePromptPopUp({super.key});

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
              builder: (context) => const UsePromptWidget(),
            );
          },
          child: const Text('Show Center Popup'),
        ),
      ),
    );
  }
}

class UsePromptWidget extends StatefulWidget {
  const UsePromptWidget({super.key});

  @override
  _UsePromptWidgetState createState() => _UsePromptWidgetState();
}

class _UsePromptWidgetState extends State<UsePromptWidget> {
  bool _isPromptVisible = false;

  void _togglePromptVisibility() {
    setState(() {
      _isPromptVisible = !_isPromptVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Winston, the best therapist with 1000 years of experience',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.star_border),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Other · Jarvis Team',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              const Text(
                'As the best therapist ever, Winston could ask open-ended questions and offer advice, helping you identify what might be bothering you.',
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _togglePromptVisibility,
                child: Text(
                  _isPromptVisible ? 'Hide Prompt' : 'View Prompt',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              if (_isPromptVisible) ...[
                const SizedBox(height: 8),
                const Text(
                  'This is the content of the prompt. It will be displayed when the "View Prompt" button is pressed.',
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Output Language',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: 'Auto',
                    items: <String>['Auto', 'English', 'Spanish', 'French']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

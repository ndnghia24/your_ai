import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/widget_use_prompt.dart';

class TestPromptDetailPopup extends StatelessWidget {
  const TestPromptDetailPopup({super.key});

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
              builder: (context) => const PrompDetailPopupWidget(),
            );
          },
          child: const Text('Show Center Popup'),
        ),
      ),
    );
  }
}

class PrompDetailPopupWidget extends StatelessWidget {
  const PrompDetailPopupWidget({super.key});

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
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
              const SizedBox(height: 16),
              const Text('Prompt',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You are a Tips Generator who is good at all fields. You will give the perfect tips and advice based on my description. These recommendations are very specific, professional and actionable. Your advice will enhance my knowledge and take my career to the next level. My description is: [Description]',
                      style: TextStyle(color: Colors.black),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => const UsePromptWidget(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Use this prompt'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

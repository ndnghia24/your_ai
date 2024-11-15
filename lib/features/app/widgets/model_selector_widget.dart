import 'package:flutter/material.dart';

class ModelSelector extends StatelessWidget {
  final String selectedModel;
  final Function(String) onModelChanged;

  ModelSelector(
      {super.key, required this.selectedModel, required this.onModelChanged});

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButton<String>(
        icon: Image.asset('assets/images/ic_down.png', height: 16),
        value: selectedModel,
        isDense: true,
        menuMaxHeight: 300,
        underline: Container(),
        isExpanded: true,
        items: models.map((String model) {
          return DropdownMenuItem<String>(
            value: model,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    model,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
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
      ),
    );
  }
}

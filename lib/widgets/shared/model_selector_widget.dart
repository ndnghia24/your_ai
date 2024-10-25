// Custom Dropdown Widget for model selection
import 'package:flutter/material.dart';
import 'package:jarvis_ai/helper/CustomColors.dart';
import 'package:jarvis_ai/helper/CustomTextStyles.dart';

class ModelSelector extends StatelessWidget {
  final String selectedModel;
  final Function(String) onModelChanged;

  ModelSelector(
      {super.key, required this.selectedModel, required this.onModelChanged});

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
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: CustomTextStyles.captionLarge.fontSize,
                    color: CustomColors.textDarkGrey,
                  ),
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
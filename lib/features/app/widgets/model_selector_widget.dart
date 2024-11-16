import 'package:flutter/material.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';


class ModelSelector extends StatelessWidget {
  final GenerativeAiModel selectedModel;
  final Function(GenerativeAiModel) onModelChanged;

  ModelSelector({
    super.key,
    required this.selectedModel,
    required this.onModelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButton<GenerativeAiModel>(
        icon: Image.asset('assets/images/ic_down.png', height: 16),
        value: selectedModel,
        isDense: true,
        menuMaxHeight: 300,
        underline: Container(),
        isExpanded: true,
        items: generativeAiAssistants.keys.map((GenerativeAiModel model) {
          final assistant = generativeAiAssistants[model]!;
          return DropdownMenuItem<GenerativeAiModel>(
            value: model,
            child: Row(
              children: [
                assistant.icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    assistant.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (GenerativeAiModel? newValue) {
          if (newValue != null) {
            onModelChanged(newValue); // Call the callback function
          }
        },
      ),
    );
  }
}
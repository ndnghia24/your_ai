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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<GenerativeAiModel>(
          icon: Icon(Icons.keyboard_arrow_down_rounded, 
            color: Colors.grey.shade700,
            size: 20,
          ),
          value: selectedModel,
          isDense: true,
          menuMaxHeight: 300,
          elevation: 8,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          items: generativeAiAssistants.keys.map((GenerativeAiModel model) {
            final assistant = generativeAiAssistants[model]!;
            return DropdownMenuItem<GenerativeAiModel>(
              value: model,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    child: assistant.icon,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      assistant.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (GenerativeAiModel? newValue) {
            if (newValue != null) {
              onModelChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
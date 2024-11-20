import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';

class PromptCategorySelector extends StatelessWidget {
  //remove ALL from the list
  final List<Map<String, dynamic>> promptCatgories = PROMPT_CATEGORY_ITEMS.sublist(1);
  final PromptCategory selectedCategory;
  final ValueChanged<PromptCategory?> onChanged;

   PromptCategorySelector({
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: screenColorScheme.surfaceContainer,
          ),
          child: DropdownButtonFormField<PromptCategory>(
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            value: selectedCategory,
            items: promptCatgories.map((value) {
              return DropdownMenuItem<PromptCategory>(
                value: value['value'],
                child: Text(value['label']),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
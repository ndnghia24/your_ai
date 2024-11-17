import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/public_prompts_tab/widgets/prompt_category_filter/widgets/prompt_category_filter_item.dart';

class PromptCategoryFilter extends StatelessWidget {
   PromptCategoryFilter({super.key, required this.category, required this.onCategorySelected});
  final PromptCategory category;
  final void Function(PromptCategory) onCategorySelected;
  final List<Map<String, dynamic>> promptCategory = PROMPT_CATEGORY_ITEMS;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: promptCategory.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = promptCategory[index];
        return GestureDetector(
          onTap: () => onCategorySelected(item['value']??PromptCategory.ALL),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: PromptCategoryFilterItem(
              category: item['label'],
              isSelected: item['value'] == category,
            ),
          ),
        );
      },
    );
  }
}
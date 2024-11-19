import 'package:flutter/material.dart';
import 'package:your_ai/core/utils/CustomTextStyles.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class PublicPromptItem extends StatelessWidget {
  const PublicPromptItem({
    Key? key,
    required this.prompt,
    required this.onUsePrompt,
    required this.onAddFavorite,
    required this.onRemoveFavorite,
    required this.onViewInfo,
  }) : super(key: key);

  final Prompt prompt;
  final Function(Prompt) onUsePrompt;
  final Function(Prompt) onAddFavorite;
  final Function(Prompt) onRemoveFavorite;
  final Function(Prompt) onViewInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onUsePrompt(prompt);
      },
      child: ListTile(
        title: Text(prompt.title,
            style: TextStyle(fontSize: CustomTextStyles.headlineSmall.fontSize)),
        subtitle: Text(
          prompt.description,
          style: TextStyle(fontSize: CustomTextStyles.bodyLarge.fontSize),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                prompt.isFavorite ? Icons.star : Icons.star_border,
                size: 25,
                color: prompt.isFavorite ? Colors.red : Colors.blue,
              ),
              onPressed: () {
                prompt.isFavorite ? onRemoveFavorite(prompt) : onAddFavorite(prompt);
              },
            ),
          ],
        ),
      ),
    );
  }
}

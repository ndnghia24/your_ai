import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:flutter/cupertino.dart';

class PublicPromptItem extends StatelessWidget {
  const PublicPromptItem({
    Key? key,
    required this.prompt,
    required this.onUsePrompt,
    required this.onAddFavorite,
    required this.onRemoveFavorite,
  }) : super(key: key);

  final Prompt prompt;
  final Function(Prompt) onUsePrompt;
  final Function(Prompt) onAddFavorite;
  final Function(Prompt) onRemoveFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onUsePrompt(prompt);
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        title: Text(prompt.title, style: TextStyle(fontSize: 16)),
        subtitle: Text(
          prompt.description,
          style: TextStyle(fontSize: 13),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                prompt.isFavorite
                    ? CupertinoIcons.star_circle_fill
                    : CupertinoIcons.star_circle,
                size: 25,
                color: prompt.isFavorite ? Colors.red : Colors.blue,
              ),
              onPressed: () {
                prompt.isFavorite
                    ? onRemoveFavorite(prompt)
                    : onAddFavorite(prompt);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:your_ai/core/utils/CustomTextStyles.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';

class PrivatePromptItem extends StatelessWidget {
  const PrivatePromptItem({
    Key? key,
    required this.prompt,
    required this.onUsePrompt,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final Prompt prompt;
  final Function(Prompt) onUsePrompt;
  final Function(Prompt) onEdit;
  final Function(Prompt) onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUsePrompt != null ? () => onUsePrompt(prompt) : null,
      child: ListTile(
        title: Text(prompt.title,
            style: TextStyle(fontSize: CustomTextStyles.headlineSmall.fontSize)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 25),
              onPressed: () {
                onEdit(prompt);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 25),
              onPressed: () {
                onDelete(prompt);
              },
            ),
          ],
        ),
      ),
    );
  }
}

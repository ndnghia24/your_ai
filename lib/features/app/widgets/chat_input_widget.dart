import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/prompt_popup.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/use_prompt_dialog.dart';

import '../../chat_prompt/presentation/ui/prompt_library_popup.dart';

class ChatInputWidget extends StatelessWidget {
  final Function(String) onSubmitted;

  const ChatInputWidget({super.key, required this.onSubmitted});

  void _onSendPressed(BuildContext context, TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      onSubmitted(text);
      controller.clear();
    }
  }

  void _onPopupMenuSelected(BuildContext context, int value) {
    switch (value) {
      case 0:
        // Handle camera selection
        break;
      case 1:
        // Handle gallery selection
        break;
      case 2:
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
            ),
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const PromptLibraryPopupWidget(),
              ),
            ),
          ),
        );
        break;
    }
  }

  void _onSlashLetterInput(BuildContext context) {
    showDialog<Prompt>(
      context: context, 
      builder: (context) => Dialog(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(16),
          child: PromptPopup()
        ),
      ),
    ).then((prompt) {
      if (prompt != null) {
        showDialog(
      context: context,
      builder: (context) {
        return UsePromptPopup(prompt: prompt, closeDialog: (){},);
      },
    );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;
    final TextEditingController controller = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: screenColorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PopupMenuButton<int>(
            icon: Image.asset(
              'assets/images/ic_more.png',
              height: 25,
              color: Colors.grey.shade700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            onSelected: (value) => _onPopupMenuSelected(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey.shade800),
                    const SizedBox(width: 12),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.photo, color: Colors.grey.shade800),
                    const SizedBox(width: 12),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.grey.shade800),
                    const SizedBox(width: 12),
                    Text(
                      "Prompt Library",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 4,
              minLines: 1,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade900,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  onSubmitted(text);
                  controller.clear();
                }
              },
              onChanged: (text) {
                if (text.startsWith('/')) {
                  _onSlashLetterInput(context);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: screenColorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _onSendPressed(context, controller),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/ic_send.png',
                    height: 22,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

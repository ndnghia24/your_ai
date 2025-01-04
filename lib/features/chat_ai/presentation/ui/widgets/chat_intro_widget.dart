import 'package:flutter/material.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/prompt_library_popup.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/widget_use_prompt.dart';

class ChatIntroWidget extends StatelessWidget {
  const ChatIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> quickPrompts = [
      'Grammar corrector',
      'Essay Improver',
      'Instagram post Generator',
      'Pro tips generator',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('👋',
              style: TextStyle(
                color: AppColors.onSecondary,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )),
          SizedBox(height: 8),
          Text('Hi, good afternoon!',
              style: TextStyle(
                color: AppColors.onSecondary,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )),
          const SizedBox(height: 8),
          Text(
            "I'm YourAI, your personal assistant.",
            style: TextStyle(
              color: AppColors.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Don't know what to say?",
                style: TextStyle(
                    color: AppColors.onSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.8,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const PromptLibraryPopupWidget(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Use a prompt!",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          //...quickPrompts.map(
          //    (feature) => _quickPrompt(context, screenColorScheme, feature)),
        ],
      ),
    );
  }

  Widget _quickPrompt(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const UsePromptWidget(),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.onSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

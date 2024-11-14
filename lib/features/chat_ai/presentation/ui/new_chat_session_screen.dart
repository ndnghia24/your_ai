import 'package:flutter/material.dart';
import 'package:your_ai/features/app/presentation/components/my_appbar.dart';
import 'package:your_ai/features/app/widgets/chat_input_widget.dart';
import 'package:your_ai/features/app/widgets/new_app_drawer.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/new_chat_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/old_chat_widget.dart';

class ChatSessionScreen extends StatelessWidget {
  const ChatSessionScreen({super.key});

  final bool isNewChat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        drawer: FractionallySizedBox(
          widthFactor: 0.75,
          child: AppDrawerWidget(),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CustomAppBar()),
                Expanded(
                  child: Builder(
                    builder: (context) => GestureDetector(
                      onHorizontalDragEnd: (details) {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            isNewChat ? NewChatWidget() : OldChatWidget(),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ChatInputWidget()),
                            SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

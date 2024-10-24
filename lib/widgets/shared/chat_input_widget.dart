import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis_ai/helper/CustomColors.dart';
import 'package:jarvis_ai/helper/CustomTextStyles.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';

import '../prompt_library_popup_widget.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({super.key});

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CustomColors.cardColor,
      ),
      child: Row(
        children: [
          PopupMenuButton<int>(
            icon: Icon(CupertinoIcons.add_circled,
                color: Colors.blue,
                size: CustomTextStyles.displayLarge.fontSize),
            onSelected: (value) {
              // Handle selected value
              switch (value) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.8, // Chiều cao bằng nửa màn hình
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const PromptLibraryPopupWidget(),
                      ),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Camera"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.photo, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Gallery"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Prompt Library"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 4), // Reduced width to make input text longer
          Expanded(
            child: SizedBox(
              height: CustomTextStyles.headlineSmall.fontSize! * 2,
              child: TextField(
                focusNode: _focusNode,
                maxLines: null,
                style: TextStyle(
                  fontSize: CustomTextStyles.headlineSmall.fontSize,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.textLightGrey,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask me anything...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.send,
                color: CustomColors.textHyperlink,
                size: CustomTextStyles.displayLarge.fontSize),
            onPressed: () {
              _focusNode.unfocus();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatScreen()));
            },
          ),
        ],
      ),
    );
  }
}

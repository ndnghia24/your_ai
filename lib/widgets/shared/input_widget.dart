import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis_ai/helper/CustomColors.dart';
import 'package:jarvis_ai/helper/CustomTextStyles.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';

import '../prompt_library_popup_widget.dart';

class InputWidget extends StatefulWidget {
  final String hintText;
  final Widget leftIconWidget;
  final minLines;

  const InputWidget(
      {super.key,
      required this.hintText,
      required this.leftIconWidget,
      this.minLines});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
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
          const SizedBox(width: 8),
          widget.leftIconWidget,
          const SizedBox(width: 4),
          Expanded(
            child: SizedBox(
              height: widget.minLines == null
                  ? CustomTextStyles.headlineSmall.fontSize! * 2
                  : CustomTextStyles.headlineSmall.fontSize! *
                      widget.minLines *
                      2,
              child: TextField(
                focusNode: _focusNode,
                maxLines: null,
                minLines: widget.minLines,
                style: TextStyle(
                  fontSize: CustomTextStyles.headlineSmall.fontSize,
                  fontWeight: FontWeight.normal,
                  color: CustomColors.textLightGrey,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PromptCategoryFilterItem extends StatelessWidget {
  final String category;
  final bool isSelected;


  const PromptCategoryFilterItem({Key? key, required this.category, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        category,
        style: const TextStyle(fontSize: 16), // Increased font size
      ),
      backgroundColor: isSelected? Colors.grey[500] : Colors.grey[200],
    );
  }
}
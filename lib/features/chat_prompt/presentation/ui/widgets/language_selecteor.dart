import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_language.dart';


class LanguageSelector extends StatelessWidget {
  //remove ALL from the list
  final List<Language> languages = supportedLanguages;
  final String selectedLanguage;
  final ValueChanged<String?> onChanged;

   LanguageSelector({
    required this.selectedLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: screenColorScheme.surfaceContainer,
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              value: selectedLanguage,
              items: languages.map((value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                  
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/language_selecteor.dart';

class UsePromptPopup extends StatefulWidget {
  final Prompt prompt;
  const UsePromptPopup({super.key, required this.prompt});

  @override
  _UsePromptPopupState createState() => _UsePromptPopupState();
}

class _UsePromptPopupState extends State<UsePromptPopup> {
  bool _isPromptVisible = false;
  String _selectedLanguage = 'English';
  String promptContent = '';
  List<String> paramList = [];
  Map<String, String> paramValues = {};

  void _togglePromptVisibility() {
    setState(() {
      _isPromptVisible = !_isPromptVisible;
    });
  }

  void _onLanguageSelected(String? language) {
    setState(() {
      _selectedLanguage = language ?? 'English';
    });
  }

  void _onSubmit() {
    promptContent = widget.prompt.content;
    paramList.forEach((value) {
      promptContent =
          promptContent.replaceAllMapped(PROMPT_INPUT_PARAM_REGEX, (match) {
        final param = match.group(1);
        return param != null && param == value && paramValues.containsKey(param)
            ? paramValues[param]!
            : '';
      });
    });
  }

    @override
    void initState() {
      super.initState();
      promptContent = widget.prompt.content;
      final Set<String> params = <String>{};
      RegExpMatch? match;

      while ((match = PROMPT_INPUT_PARAM_REGEX.firstMatch(promptContent)) !=
          null) {
        params.add(match!.group(1)!);
        promptContent = promptContent.substring(match.end);
      }

      paramList = params.toList();
    }

    @override
    Widget build(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        widget.prompt.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_border),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(widget.prompt.category + ' · ' + widget.prompt.userName,
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  widget.prompt.description,
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _togglePromptVisibility,
                  child: Text(
                    _isPromptVisible ? 'Hide Prompt' : 'View Prompt',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                if (_isPromptVisible) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.prompt.content,
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: LanguageSelector(
                          selectedLanguage: _selectedLanguage,
                          onChanged: _onLanguageSelected,
                        )
                    ),
                
                for (final param in paramList) ...[
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: param,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      paramValues[param] = value;
                    },
                  ),
                ],
        
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

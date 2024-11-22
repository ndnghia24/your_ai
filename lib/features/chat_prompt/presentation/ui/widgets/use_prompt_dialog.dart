import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/prompt_library_popup.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/language_selector.dart';

class UsePromptPopup extends StatefulWidget {
  final Prompt prompt;
  final void Function() closeDialog;
  const UsePromptPopup({super.key, required this.prompt, required this.closeDialog, });

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

  String _onSubmit() {
    String result = widget.prompt.content;
    paramList.forEach((value) {
      result = result.replaceAllMapped(PROMPT_INPUT_PARAM_REGEX, (match) {
        final param = match.group(1);
        return param != null && param == value && paramValues.containsKey(param)
            ? paramValues[param]!
            : '';
      });
    });
    result += '\n\nResponse in $_selectedLanguage';
    return result;
  }

  @override
  void initState() {
    super.initState();
    promptContent = widget.prompt.content;
    final Set<String> params = <String>{};
    RegExpMatch? match;

    while (
        (match = PROMPT_INPUT_PARAM_REGEX.firstMatch(promptContent)) != null) {
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
      child: BlocBuilder<ModelBloc, ModelState>(
          bloc: GetIt.I<ModelBloc>(),
          builder: (modelContext, modelState) {
            return BlocBuilder<ConversationBloc, ConversationState>(
                bloc: GetIt.I<ConversationBloc>(),
                builder: (context, state) {
                  return SingleChildScrollView(
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.star_border),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                              widget.prompt.category +
                                  ' · ' +
                                  widget.prompt.userName,
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
                              height: 80,
                              child: LanguageSelector(
                                selectedLanguage: _selectedLanguage,
                                onChanged: _onLanguageSelected,
                              )),
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
                              onPressed: () {
                                GenerativeAiModel selectedModel =
                                    GenerativeAiModel.gpt4oMini;
                                if (modelState is ModelInitial) {
                                  selectedModel = modelState.selectedModel;
                                }

                                final assistant =
                                    generativeAiAssistants[selectedModel]!;
                                if (state is ConversationLoaded) {
                                  GetIt.I<ConversationBloc>().add(
                                    ContinueConversation(
                                      content: _onSubmit(),
                                      assistant: {
                                        'id': assistant.id,
                                        'model': assistant.model,
                                      },
                                      conversation: state.conversation.toMap(),
                                    ),
                                  );
                                } else if (state is ConversationInitial) {
                                  GetIt.I<ConversationBloc>()
                                      .add(
                                    CreateNewConversation(
                                      content: _onSubmit(),
                                      assistantId: assistant.id,
                                      assistantModel: assistant.model,
                                    ),
                                  );
                                }

                                //how to close the dialog and modal bottom?
                                widget.closeDialog();
                                Navigator.pop(context, true);

                              },
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
                  );
                });
          }),
    );
  }
}

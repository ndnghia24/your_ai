import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_event.dart';

import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/language_selecteor.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/create_or_update_prompt_dialog/widgets/prompt_category_selector.dart';

class CreateOrUpdatePromptPopup extends StatefulWidget {
  final Prompt? prompt;

  const CreateOrUpdatePromptPopup(
      {Key? key, this.prompt})
      : super(key: key);

  @override
  _CreateOrUpdatePromptPopupState createState() => _CreateOrUpdatePromptPopupState();
}

class _CreateOrUpdatePromptPopupState extends State<CreateOrUpdatePromptPopup> {
  final _formKey = GlobalKey<FormState>();
  bool isPrivatePrompt = true;

  void _updatePrivatePrompt(Prompt prompt) {
    final state = BlocProvider.of<PromptBloc>(context).state;
    if (state is PromptLoaded) {
      final privatePrompts = state.privatePrompts;
      final publicPrompts = state.publicPrompts;
      BlocProvider.of<PromptBloc>(context).add(UpdatePrivatePromptEvent(
        prompt.id,
        prompt.title,
        prompt.description,
        prompt.content,
        prompt.category,
        prompt.language,
        prompt.isPublic,
        publicPrompts,
        privatePrompts,
      ));
    }
  }

  void _createNewPrompt(Prompt prompt) {
    final state = BlocProvider.of<PromptBloc>(context).state;
    if (state is PromptLoaded) {
      final privatePrompts = state.privatePrompts;
      final publicPrompts = state.publicPrompts;
      if (prompt.isPublic) {
        BlocProvider.of<PromptBloc>(context).add(AddNewPublicPromptEvent(
          prompt.title,
          prompt.description,
          prompt.content,
          prompt.category,
          prompt.language,
          publicPrompts,
          privatePrompts,
        ));
      } else {
        BlocProvider.of<PromptBloc>(context).add(AddNewPrivatePromptEvent(
          prompt.title,
          prompt.description,
          prompt.content,
          publicPrompts,
          privatePrompts,
        ));
      }
    }
  }

  // Input controllers
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _promptController;
  PromptCategory _selectedCategory = PromptCategory.OTHER;
  String _selectedLanguage = 'English';

  void _onCategorySelected(PromptCategory? category) {
    setState(() {
      _selectedCategory = category ?? PromptCategory.OTHER;
    });
  }

  void _onLanguageSelected(String? language) {
    setState(() {
      _selectedLanguage = language ?? 'English';
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers based on prompt state
    if (widget.prompt != null) {
      final prompt = widget.prompt!;
      _nameController = TextEditingController(text: prompt.title);
      _descriptionController = TextEditingController(text: prompt.description);
      _promptController = TextEditingController(text: prompt.content);
      isPrivatePrompt = !prompt.isPublic;
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
      _promptController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;
    final isEditMode = widget.prompt != null;

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<PromptBloc, PromptState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(
                      title: isEditMode ? 'Edit Prompt' : 'New Prompt',
                      onClose: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 16),
                    _PrivacyOption(
                      isPrivatePrompt: isPrivatePrompt,
                      onChanged: (value) {
                        setState(() {
                          isPrivatePrompt = value ?? true;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    if (!isPrivatePrompt)
                      SizedBox(
                      width: double.infinity,
                      height: 80,
                      child: LanguageSelector(
                        selectedLanguage: _selectedLanguage,
                        onChanged: _onLanguageSelected,
                      ),
                      ),
                    _FormInputField(
                      label: 'Name',
                      controller: _nameController,
                      hintText: 'Name of the prompt',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    if (!isPrivatePrompt)
                    PromptCategorySelector(
                      selectedCategory: _selectedCategory,
                      onChanged: _onCategorySelected,
                    ),
                    _FormInputField(
                      label: 'Description',
                      controller: _descriptionController,
                      hintText: 'Enter a description...',
                      minLines: 3,
                      validator: (value) {
                        if (value != null && value.length < 10) {
                          return 'Description must be at least 10 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    _FormInputField(
                      label: 'Prompt',
                      controller: _promptController,
                      hintText:
                          'Use square brackets [ ] to specify user input. e.g: Write an article about [TOPIC], make sure to include these keywords: [KEYWORDS]',
                      minLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Prompt content is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _ActionButtons(
                        isEditMode: isEditMode,
                        onCancel: () => Navigator.pop(context),
                        onCreate: () {
                          if (_formKey.currentState!.validate()) {
                            if (isEditMode) {
                              Prompt updatedPrompt = new Prompt(
                                id: widget.prompt!.id,
                                title: _nameController.text,
                                description: _descriptionController.text,
                                content: _promptController.text,
                                category: _selectedCategory.name,
                                isPublic: !isPrivatePrompt,
                                  userName: 'user',
                                  isFavorite: false,
                              );

                              _updatePrivatePrompt(updatedPrompt);
                              Navigator.pop(context);
                            } else {
                              if (isPrivatePrompt) {
                                Prompt newPrompt = new Prompt(
                                  id: '0',
                                  title: _nameController.text,
                                  description: _descriptionController.text,
                                  content: _promptController.text,
                                  category: _selectedCategory.name,
                                  isPublic: false,
                                  userName: 'user',
                                  isFavorite: false,
                                );

                                _createNewPrompt(newPrompt);
                              } else {
                                Prompt newPrompt = new Prompt(
                                  id: '0',
                                  title: _nameController.text,
                                  description: _descriptionController.text,
                                  content: _promptController.text,
                                  category: _selectedCategory.name,
                                  language: _selectedLanguage,
                                  isPublic: true,
                                  userName: 'user',
                                  isFavorite: false,
                                );

                                _createNewPrompt(newPrompt);
                              }
                              Navigator.pop(context);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onClose;
  final String title;

  const _Header({required this.onClose, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
      ],
    );
  }
}

class _PrivacyOption extends StatelessWidget {
  final bool isPrivatePrompt;
  final ValueChanged<bool?> onChanged;

  const _PrivacyOption(
      {required this.isPrivatePrompt, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildOption(
          title: 'Private Prompt',
          value: true,
          groupValue: isPrivatePrompt,
          onChanged: onChanged,
        ),
        _buildOption(
          title: 'Public Prompt',
          value: false,
          groupValue: isPrivatePrompt,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildOption({
    required String title,
    required bool value,
    required bool groupValue,
    required ValueChanged<bool?> onChanged,
  }) {
    return Expanded(
      child: Row(
        children: [
          Radio<bool>(
            value: value,
            groupValue: groupValue,
            activeColor: Colors.blue,
            onChanged: onChanged,
          ),
          Text(title),
        ],
      ),
    );
  }
}

class _FormInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final String? Function(String?) validator;

  const _FormInputField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.minLines = 1,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10), // Padding nội dung
          ),
          minLines: minLines,
          maxLines: minLines,
          validator: validator,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onCreate;
  final bool isEditMode;

  const _ActionButtons({required this.onCancel, required this.onCreate, this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    var title = isEditMode ? 'Save' : 'Create';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onCreate,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child:  Text(title),
        ),
      ],
    );
  }
}

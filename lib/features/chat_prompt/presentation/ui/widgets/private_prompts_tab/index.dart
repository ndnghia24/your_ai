import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_event.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/create_or_update_prompt_dialog/index.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/private_prompts_tab/widgets/private_prompt_item.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/use_prompt_dialog.dart';

class PrivatePromptTab extends StatefulWidget {
  const PrivatePromptTab({super.key});

  @override
  State<PrivatePromptTab> createState() => _PrivatePromptTabState();
}

class _PrivatePromptTabState extends State<PrivatePromptTab> {
  String searchText = '';
  final FocusNode _focusNode = FocusNode();

  void onEditPrompt(Prompt prompt) {
    final bloc = BlocProvider.of<PromptBloc>(context);
    showDialog(
        context: context,
        builder: (dialogContext) {
          return BlocProvider.value(
              value: bloc,
              child: CreateOrUpdatePromptPopup(
                prompt: prompt,
              ));
        });
  }

  void onDeletePrompt(Prompt prompt) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return BlocProvider.value(
            value: BlocProvider.of<PromptBloc>(context),
            child: BlocBuilder<PromptBloc, PromptState>(
              builder: (context, state) => AlertDialog(
                title: Text('Delete Prompt'),
                content: Text('Are you sure you want to delete this prompt?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[500],
                    ),
                    onPressed: () {
                      final state = BlocProvider.of<PromptBloc>(context).state;
                      if (state is PromptLoaded) {
                        BlocProvider.of<PromptBloc>(context).add(
                            DeletePrivatePromptEvent(prompt.id,
                                state.publicPrompts, state.privatePrompts));
                      }
                      Navigator.of(dialogContext).pop(true);
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void closeModalBottom() {
    Navigator.pop(context);
  }

  void onUsePrompt(Prompt prompt) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return UsePromptPopup(prompt: prompt, closeDialog: closeModalBottom);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptBloc, PromptState>(
      builder: (context, state) {
        if (state is PromptInitial) {
          BlocProvider.of<PromptBloc>(context).add(GetAllPromptEvent());
          return Center(child: CircularProgressIndicator());
        }

        if (state is PromptLoading) {
          final prompts = state.privatePrompts;
          final filteredPrompts = prompts
              .where((prompt) =>
                  prompt.title.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          final displayPrompts =
              _focusNode.hasFocus ? prompts : filteredPrompts;
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                      style: TextStyle(fontSize: 14),
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) {
                        searchText = value;
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayPrompts.length,
                      itemBuilder: (context, index) {
                        return PrivatePromptItem(
                          prompt: displayPrompts[index],
                          onUsePrompt: onUsePrompt,
                          onEdit: onEditPrompt,
                          onDelete: onDeletePrompt,
                        );
                      },
                    ),
                  ),
                ],
              ),
              ModalBarrier(
                color: Colors.white.withOpacity(0.5),
                dismissible: false,
              ),
              Center(
                child: Image.asset(
                  'assets/images/loading_capoo.gif',
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ],
          );
        }

        if (state is PromptLoaded) {
          final prompts = state.privatePrompts;
          final filteredPrompts = prompts
              .where((prompt) =>
                  prompt.title.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          final displayPrompts =
              _focusNode.hasFocus ? prompts : filteredPrompts;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    searchText = value;
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: displayPrompts.length,
                  itemBuilder: (context, index) {
                    return PrivatePromptItem(
                      prompt: displayPrompts[index],
                      onUsePrompt: onUsePrompt,
                      onEdit: onEditPrompt,
                      onDelete: onDeletePrompt,
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

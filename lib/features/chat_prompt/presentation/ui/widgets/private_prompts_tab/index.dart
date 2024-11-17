import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_event.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/create_or_update_prompt_dialog/index.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/private_prompts_tab/widgets/private_prompt_item.dart';

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
              value: bloc, child: CreateOrUpdatePromptPopup(prompt: prompt,));
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
                  child: Text('Cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                  ),
                  onPressed: () {
                    final state = BlocProvider.of<PromptBloc>(context).state;
                    if(state is PromptLoaded) {
                      BlocProvider.of<PromptBloc>(context).add(DeletePrivatePromptEvent(
                        prompt.id,
                        state.publicPrompts,
                        state.privatePrompts
                        )
                        );
                    }
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void onUsePrompt(Prompt prompt) {}

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
          return Center(child: CircularProgressIndicator());
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
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

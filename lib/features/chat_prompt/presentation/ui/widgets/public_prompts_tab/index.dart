import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/enum_prompt.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_event.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/public_prompts_tab/widgets/prompt_category_filter/index.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/public_prompts_tab/widgets/public_prompt_item.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/use_prompt_dialog.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/widget_use_prompt.dart';

class PublicPromptTab extends StatefulWidget {
  const PublicPromptTab({super.key});

  @override
  State<PublicPromptTab> createState() => _PublicPromptTabState();
}

class _PublicPromptTabState extends State<PublicPromptTab> {
  String searchText = '';
  bool isFavorite = false;
  final FocusNode _focusNode = FocusNode();
  PromptCategory selectedCategory = PromptCategory.ALL;
  final promptCategories = PROMPT_CATEGORY_ITEMS;

  void onAddFavorite(Prompt prompt) {
    final state = BlocProvider.of<PromptBloc>(context).state;
    if (state is PromptLoaded) {
      BlocProvider.of<PromptBloc>(context).add(AddFavoritePromptEvent(
        prompt.id,
        state.publicPrompts,
        state.privatePrompts,
      ));
    }
  }

  void closeModalBottom() {
    Navigator.pop(context);
  }

  void onRemoveFavorite(Prompt prompt) {
    final state = BlocProvider.of<PromptBloc>(context).state;
    if (state is PromptLoaded) {
      BlocProvider.of<PromptBloc>(context).add(RemoveFavoritePromptEvent(
        prompt.id,
        state.publicPrompts,
        state.privatePrompts,
      ));
    }
  }

  void onUsePrompt(Prompt prompt) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return UsePromptPopup(
          prompt: prompt,
          closeDialog: closeModalBottom,
        );
      },
    );

    if (result == true) {
      Navigator.pop(context, true);
    }
  }

  void onClickFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void onCategorySelected(PromptCategory category) {
    setState(() {
      selectedCategory = category;
    });
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
          final prompts = state.publicPrompts;
          final filteredPrompts = prompts
              .where((prompt) =>
                  prompt.title.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          final displayPrompts = isFavorite
              ? filteredPrompts.where((prompt) => prompt.isFavorite).toList()
              : filteredPrompts;
          final categoryFilteredPrompts = selectedCategory == PromptCategory.ALL
              ? displayPrompts
              : displayPrompts
                  .where((prompt) => prompt.category == selectedCategory.name)
                  .toList();

          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            style: TextStyle(fontSize: 14),
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
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? CupertinoIcons.star_circle_fill
                                : CupertinoIcons.star_circle,
                            color: isFavorite ? Colors.red : Colors.blue,
                            size: 30,
                          ),
                          onPressed: onClickFavorite,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    width: double.infinity, // Chiều rộng tối đa
                    child: PromptCategoryFilter(
                      category: selectedCategory,
                      onCategorySelected: onCategorySelected,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: categoryFilteredPrompts.length,
                      itemBuilder: (context, index) {
                        return PublicPromptItem(
                          prompt: categoryFilteredPrompts[index],
                          onUsePrompt: onUsePrompt,
                          onAddFavorite: onAddFavorite,
                          onRemoveFavorite: onRemoveFavorite,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
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
          final prompts = state.publicPrompts;
          final filteredPrompts = prompts
              .where((prompt) =>
                  prompt.title.toLowerCase().contains(searchText.toLowerCase()))
              .toList();
          final displayPrompts = isFavorite
              ? filteredPrompts.where((prompt) => prompt.isFavorite).toList()
              : filteredPrompts;
          final categoryFilteredPrompts = selectedCategory == PromptCategory.ALL
              ? displayPrompts
              : displayPrompts
                  .where((prompt) => prompt.category == selectedCategory.name)
                  .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _focusNode,
                        style: TextStyle(fontSize: 14),
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
                    IconButton(
                      icon: Icon(
                        isFavorite
                            ? CupertinoIcons.star_circle_fill
                            : CupertinoIcons.star_circle,
                        color: isFavorite ? Colors.red : Colors.blue,
                        size: 30,
                      ),
                      onPressed: onClickFavorite,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 50,
                width: double.infinity, // Chiều rộng tối đa
                child: PromptCategoryFilter(
                  category: selectedCategory,
                  onCategorySelected: onCategorySelected,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: categoryFilteredPrompts.length,
                  itemBuilder: (context, index) {
                    return PublicPromptItem(
                      prompt: categoryFilteredPrompts[index],
                      onUsePrompt: onUsePrompt,
                      onAddFavorite: onAddFavorite,
                      onRemoveFavorite: onRemoveFavorite,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
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

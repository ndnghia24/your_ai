import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/chat_ai/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_ai/presentation/blocs/prompt_event.dart';
import 'package:your_ai/features/chat_ai/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/domain/entities/prompt.dart';
final getIt = GetIt.instance;
class PromptPopup extends StatelessWidget {
  const PromptPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPromptBloc, ChatPromptState>(
      bloc: getIt<ChatPromptBloc>(),
      builder: (context, state) {
        if (state is ChatPromptInitial) {
          getIt<ChatPromptBloc>().add(GetAllPromptEvent());
          return Center(child: CircularProgressIndicator());
        } else if (state is ChatPromptLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ChatPromptLoaded) {
          List<Prompt> allPrompts = state.privatePrompts + state.publicPrompts;

          return ListView.builder(
            itemCount: allPrompts.length,
            itemBuilder: (context, index) {
              final prompt = allPrompts[index];
              return ListTile(
                title: Text(prompt.title),
                onTap: () {
                  Navigator.of(context).pop(prompt);
                },
              );
            },
          );
        } else if (state is ChatPromptError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
      
      
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_bloc.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_state.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/chatbot_preview_screen.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/popup_new_chatbot.dart';

final getIt = GetIt.instance;

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  void showNewChatBotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateAssistantDialog();
      },
    );
  }

  void showUpdateChatBotDialog(BuildContext context, Assistant assistant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateAssistantDialog(assistant: assistant);
      },
    );
  }

  void _onDeleteAssistant(Assistant assistant) {
    final state = getIt<AssistantBloc>().state;
    if (state is AssistantLoaded) {
      getIt<AssistantBloc>()
          .add(DeleteAssistantEvent(assistant.id, state.assistants));
    }
  }

  @override
  void initState() {
    super.initState();
    getIt<AssistantBloc>().add(GetAllAssistantEvent());
  }

  @override
  Widget build(BuildContext context) {
    if (getIt<AssistantBloc>().state is AssistantInitial ||
        getIt<AssistantBloc>().state is AssistantError) {
      getIt<AssistantBloc>().add(GetAllAssistantEvent());
    }

    return BlocBuilder<AssistantBloc, AssistantState>(
        bloc: getIt<AssistantBloc>(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Chat Bots'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is AssistantLoading)
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.assistants.length,
                            itemBuilder: (context, index) {
                              final assistant = state.assistants[index];
                              return Card(
                                color: AppColors.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.chat),
                                  ),
                                  title: Text(assistant.name),
                                  subtitle: Text(assistant.description),
                                  trailing: Wrap(
                                    spacing: 12,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          showUpdateChatBotDialog(
                                              context, assistant);
                                        },
                                      ),
                                      IconButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        icon: Icon(Icons.delete_outline),
                                        onPressed: () {
                                          _onDeleteAssistant(assistant);
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigate to ChatBotPreviewScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatBotPreviewScreen(
                                                assistant: assistant,
                                              )),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      if (state is AssistantLoaded)
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.assistants.length,
                            itemBuilder: (context, index) {
                              final assistant = state.assistants[index];
                              return Card(
                                color: AppColors.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.chat),
                                  ),
                                  title: Text(assistant.name),
                                  subtitle: Text(assistant.description),
                                  trailing: Wrap(
                                    spacing: 12,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          showUpdateChatBotDialog(
                                              context, assistant);
                                        },
                                      ),
                                      IconButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        icon: Icon(Icons.delete_outline),
                                        onPressed: () {
                                          _onDeleteAssistant(assistant);
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigate to ChatBotPreviewScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatBotPreviewScreen(
                                                assistant: assistant,
                                              )),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            // Action to create new bot
                            showNewChatBotDialog(context);
                          },
                          backgroundColor: AppColors.primary,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  if (state is AssistantLoading)
                    ModalBarrier(
                      color: Colors.white.withOpacity(0.5),
                      dismissible: false,
                    ),
                  if (state is AssistantLoading)
                    Center(
                      child: Image.asset(
                        'assets/images/loading_capoo.gif',
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation_list.dart';

import '../../chat_ai/presentation/ui/widgets/widget_authentication.dart';
import '../../chat_bot/presentation/chatbot_screen.dart';
import '../../knowledge_base/knowledgebase_screen.dart';
import '../home_screen.dart';

final getIt = GetIt.instance;

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  bool showAllChats = false;

  Future<ConversationList> _loadConversations() async {
    final chatAIUseCaseFactory = getIt<ChatAIUseCaseFactory>();
    final result = await chatAIUseCaseFactory.getConversationsUseCase.execute(
      assistantId: 'gpt-4o-mini',
      assistantModel: 'dify',
    );

    if (result.isSuccess) {
      return result.result;
    } else {
      throw Exception(result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 20;
    final double verticalPadding = 10;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/yourai_logo.png', height: 40),
                  SizedBox(width: 8),
                  Text(
                    'Your AI',
                    style: GoogleFonts.bebasNeue(fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: showAllChats
                      ? _buildAllChatsList()
                      : _buildDefaultContent(),
                ),
                showAllChats
                    ? Container()
                    : MultiBlocProvider(
                        providers: [
                          BlocProvider<AuthBloc>(
                            create: (context) => getIt<AuthBloc>(),
                          ),
                        ],
                        child:
                            AuthenticationWidget(), // Use AuthenticationWidget here
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
              leading: Image.asset('assets/images/op_newchat.png', height: 20),
              title: Text(
                'NEW CHAT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading: Image.asset('assets/images/op_allchat.png', height: 25),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'ALL CHAT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Image.asset('assets/images/ic_next.png', height: 18)
              ],
            ),
            onTap: () {
              setState(() {
                showAllChats = true;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading: Image.asset('assets/images/op_chatbot.png', height: 20),
            title: Text(
              'CHAT BOTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatBotScreen()),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ListTile(
            leading:
                Image.asset('assets/images/op_knowledgebase.png', height: 20),
            title: Text(
              'KNOWLEDGE BASE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllChatsList() {
    return Column(
      children: [
        ListTile(
          leading: Image.asset('assets/images/ic_back.png', height: 20),
          title: Text(
            'BACK',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          tileColor: Colors.grey.shade300,
          onTap: () {
            setState(() {
              showAllChats = false;
            });
          },
        ),
        Expanded(
          child: FutureBuilder<ConversationList>(
            future: _loadConversations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.grey.shade900),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final conversationList = snapshot.data!;
                return BlocBuilder<ConversationBloc, ConversationState>(
                  builder: (context, state) {
                    final currentConversationId = (state is ConversationLoaded)
                        ? state.conversation.id
                        : null;
                    return ListView.builder(
                      itemCount: conversationList.conversationsList.length,
                      itemBuilder: (context, index) {
                        final conversation =
                            conversationList.conversationsList[index];
                        final isSelected =
                            conversation['id'] == currentConversationId;
                        return Container(
                          color: isSelected
                              ? Colors.grey.shade400
                              : Colors.transparent,
                          child: ListTile(
                            leading: Icon(Icons.chat_bubble),
                            title: Text(conversation['title']),
                            onTap: () {
                              if(isSelected) {
                                return;
                              }
                              BlocProvider.of<ConversationBloc>(context).add(
                                LoadConversation(conversation['id']),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Center(child: Text('No conversations found.'));
              }
            },
          ),
        ),
      ],
    );
  }
}

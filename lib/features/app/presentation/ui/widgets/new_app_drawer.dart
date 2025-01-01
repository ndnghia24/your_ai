import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/routes/route.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/core/utils/ga4_service.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_event.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_state.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/app/presentation/ui/screens/admob_banner_ads_widget.dart';
import 'package:your_ai/features/app/presentation/ui/screens/banner_ads_widget.dart';
import 'package:your_ai/features/auth/presentation/ui/widget_authentication.dart';
import 'package:your_ai/features/chat_ai/domain/chat_usecase_factory.dart';
import 'package:your_ai/features/chat_ai/domain/entities/conversation_list.dart';
import 'package:your_ai/features/email_response/presentation/ui/email_srceen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/knowledgebase_screen.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/chatbot_screen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

final getIt = GetIt.instance;

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget>
    with SingleTickerProviderStateMixin {
  bool _showAllChats = false;
  late final AnimationController _animationController;
  late final Animation<Offset> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _drawerSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<ConversationList> _loadConversations() async {
    final chatAIUseCaseFactory = getIt<ChatAIUseCaseFactory>();
    final result = await chatAIUseCaseFactory.getConversationsUseCase.execute(
      assistantId: 'gpt-4o-mini',
      assistantModel: 'dify',
    );

    if (result.isSuccess) {
      return result.result;
    }
    throw Exception(result.message);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _drawerSlideAnimation,
      child: Drawer(
        backgroundColor: AppColors.surface,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _showAllChats
                          ? _buildAllChatsList()
                          : _buildDefaultContent(),
                    ),
                    if (!_showAllChats)
                      Column(
                        children: [
                          const Divider(
                            thickness: 2,
                          ),
                          AuthenticationWidget(),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/yourai_logo.png', height: 40),
            const SizedBox(width: 8),
            Text(
              'Your AI',
              style: GoogleFonts.bebasNeue(fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return ListView(
      children: [
        _buildNewChatTile(),
        _buildAllChatTile(),
        _buildKnowledgeBaseTile(),
        _buildChatBotsTile(),
        _buildEmailResponseTile(),
        _buildAdsTile(),
      ],
    );
  }

  Widget _buildEmailResponseTile() {
    return _buildDrawerTile(
        icon: 'assets/images/op_emailresponse.png',
        title: 'AI Emailed',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmailResponseScreen()),
          );
        });
  }

  Widget _buildNewChatTile() {
    return BlocBuilder<ConversationBloc, ConversationState>(
      bloc: getIt<ConversationBloc>(),
      builder: (context, state) {
        return _buildDrawerTile(
          icon: 'assets/images/op_newchat.png',
          title: 'Start Chat',
          onTap: () {
            getIt<ModelBloc>().add(UpdateModel(GenerativeAiModel.gpt4oMini));
            if (state is ConversationLoaded) {
              getIt<ConversationBloc>().add(ResetConversation());
            }
            getIt<GA4Service>().sendGA4Event(GA4EventNames.newChat, {});
            Get.offAllNamed(Routes.home);
          },
        );
      },
    );
  }

  Widget _buildAllChatTile() {
    return _buildDrawerTile(
      icon: 'assets/images/op_allchat.png',
      title: 'Conversations',
      showNext: true,
      onTap: () => setState(() => _showAllChats = true),
    );
  }

  Widget _buildChatBotsTile() {
    return _buildDrawerTile(
      icon: 'assets/images/op_chatbot.png',
      title: 'AI Agents',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatBotScreen()),
      ),
    );
  }

  Widget _buildKnowledgeBaseTile() {
    return _buildDrawerTile(
      icon: 'assets/images/op_knowledgebase.png',
      title: 'Knowledge Base',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KnowledgeBaseScreen()),
      ),
    );
  }

  Widget _buildDrawerTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool showNext = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 0),
      margin: const EdgeInsets.only(left: 0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        leading: Image.asset(icon, height: icon.contains('allchat') ? 25 : 20),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            if (showNext) Image.asset('assets/images/ic_next.png', height: 18),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAllChatsList() {
    return Column(
      children: [
        _buildBackButton(),
        Expanded(
          child: FutureBuilder<ConversationList>(
            future: _loadConversations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingIndicator();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return _buildEmptyState();
              }
              return _buildConversationsList(snapshot.data!);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return ListTile(
      leading: Image.asset('assets/images/ic_back.png', height: 20),
      title: const Text(
        'BACK',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      tileColor: Colors.grey.shade300,
      onTap: () => setState(() => _showAllChats = false),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CupertinoActivityIndicator(
        color: Colors.grey.shade900,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.chat_bubble_text,
            size: 48,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 16),
          Text(
            'No Conversations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a new chat to begin conversing',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(ConversationList conversationList) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      bloc: getIt<ConversationBloc>(),
      builder: (context, state) {
        final currentConversationId =
            (state is ConversationLoaded) ? state.conversation.id : null;

        if (conversationList.conversationsList.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: conversationList.conversationsList.length,
          itemBuilder: (context, index) {
            final conversation = conversationList.conversationsList[index];
            final isSelected = conversation['id'] == currentConversationId;

            return Container(
              color: isSelected ? Colors.grey.shade400 : Colors.transparent,
              child: ListTile(
                leading: const Icon(CupertinoIcons.chat_bubble_2),
                title: Text(conversation['title']),
                onTap: isSelected
                    ? null
                    : () {
                        getIt<GA4Service>()
                            .sendGA4Event(GA4EventNames.reloadConversation, {});
                        getIt<ModelBloc>()
                            .add(UpdateModel(GenerativeAiModel.gpt4oMini));
                        getIt<ConversationBloc>()
                            .add(LoadConversation(conversation['id']));
                        Navigator.pop(context);
                      },
              ),
            );
          },
        );
      },
    );
  }

  _buildAdsTile() {
    return _buildDrawerTile(
      icon: 'assets/images/op_ads.png',
      title: 'ADS',
      onTap: () {
        if (Platform.isAndroid) {
          Get.dialog(
            const AdmobBannerAdWidget(
                adUnitId: 'ca-app-pub-3940256099942544/6300978111'),
            barrierDismissible: true,
          );
        } else {
          Get.snackbar(
            'Ads',
            'Ads are only available on Android devices',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}

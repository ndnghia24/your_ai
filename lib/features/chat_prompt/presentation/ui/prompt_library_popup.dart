import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/core/utils/CustomTextStyles.dart';
import 'package:your_ai/features/chat_prompt/domain/prompt_usecase_factory.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_bloc.dart';
import 'package:your_ai/features/chat_prompt/presentation/blocs/prompt_state.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/create_or_update_prompt_dialog/index.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/private_prompts_tab/index.dart';
import 'package:your_ai/features/chat_prompt/presentation/ui/widgets/public_prompts_tab/index.dart';

final getIt = GetIt.instance;

class PromptLibraryPopupWidget extends StatefulWidget {
  const PromptLibraryPopupWidget({super.key});

  @override
  _PromptLibraryPopupWidgetState createState() =>
      _PromptLibraryPopupWidgetState();
}

class _PromptLibraryPopupWidgetState extends State<PromptLibraryPopupWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PromptBloc>(
          create: (context) => PromptBloc(getIt<ChatPromptUseCaseFactory>()),
        ),
      ],
      child: BlocBuilder<PromptBloc, PromptState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prompt Library',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold), // Increased font size
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.primary,
                        size: 30), // Increased icon size
                    onPressed: () {
                      final bloc = BlocProvider.of<PromptBloc>(context);
                      showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return BlocProvider.value(
                                value: bloc,
                                child: CreateOrUpdatePromptPopup());
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.surface,
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.primaryVariant,
                        indicatorColor: AppColors.primary,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.primary,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('My Prompt',
                                    style: TextStyle(fontSize: 14)),
                              ), // Increased font size
                            ),
                          ),
                          Tab(
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Public',
                                    style: TextStyle(
                                        fontSize: 14)), // Increased font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [PrivatePromptTab(), PublicPromptTab()],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

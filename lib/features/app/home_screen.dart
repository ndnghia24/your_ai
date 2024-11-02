import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_ai/features/chat_ai/chat_session_screen.dart';
import 'package:your_ai/features/app/widgets/chat_input_widget.dart';
import 'package:your_ai/features/app/widgets/model_selector_widget.dart';

import '../../utils/CustomTextStyles.dart';
import '../chat_ai/widgets/widget_app_drawer.dart';
import '../chat_prompt/widgets/popup_prompt_library.dart';
import '../chat_prompt/widgets/widget_use_prompt.dart';

class HomeScreen extends StatelessWidget {
  late ColorScheme screenColorScheme;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenColorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: CustomAppBar(),
        drawer: FractionallySizedBox(
          widthFactor: 0.75,
          child: AppDrawerWidget(),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
          child: GestureDetector(
            onTap: () {
              //FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                const HomeBody(),
                const ChatInputWidget(),
              ],
            ),
          ),
        ));
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedModel = 'GPT-3.5 Turbo';

  // Callback function to update the selected model
  void updateSelectedModel(String newModel) {
    setState(() {
      selectedModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.menu_sharp,
            color: screenColorScheme.onSecondary,
            size: CustomTextStyles.headlineLarge.fontSize),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: ModelSelector(
        selectedModel: selectedModel,
        onModelChanged: updateSelectedModel,
      ),
      actions: [
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: screenColorScheme.surface,
                overlayColor: Colors.transparent,
              ),
              icon: Icon(Icons.water_drop_outlined,
                  color: screenColorScheme.secondary),
              label: Text(
                '30',
                style: TextStyle(
                  color: screenColorScheme.onSecondary,
                  fontSize: CustomTextStyles.captionLarge.fontSize,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: Icon(Icons.rocket_launch,
                  color: screenColorScheme.secondary,
                  size: CustomTextStyles.captionMedium.fontSize),
              iconAlignment: IconAlignment.end,
              label: Text(
                'Upgrade',
                style: TextStyle(
                  color: screenColorScheme.secondary,
                  fontWeight: FontWeight.normal,
                  fontSize: CustomTextStyles.captionLarge.fontSize,
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('👋',
                style: TextStyle(
                  color: screenColorScheme.onSecondary,
                  fontWeight: FontWeight.normal,
                  fontSize: CustomTextStyles.titleSmall.fontSize,
                )),
            SizedBox(height: 8),
            Text('Hi, good afternoon!',
                style: TextStyle(
                  color: screenColorScheme.onSecondary,
                  fontWeight: FontWeight.normal,
                  fontSize: CustomTextStyles.titleSmall.fontSize,
                )),
            const SizedBox(height: 8),
            Text(
              "I'm YourAI, your personal assistant.",
              style: TextStyle(
                color: screenColorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: CustomTextStyles.headlineMedium.fontSize,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Don't know what to say?",
                  style: TextStyle(
                      color: screenColorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomTextStyles.headlineMedium.fontSize),
                ),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => FractionallySizedBox(
                          heightFactor: 0.5,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const PromptLibraryPopupWidget(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Use a prompt!",
                      style: TextStyle(
                        color: screenColorScheme.secondary,
                        fontSize: CustomTextStyles.bodyLarge.fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFeatureButton(
                context, screenColorScheme, 'Grammar corrector'),
            _buildFeatureButton(context, screenColorScheme, 'Essay Improver'),
            _buildFeatureButton(
                context, screenColorScheme, 'Instagram post Generator'),
            _buildFeatureButton(
                context, screenColorScheme, 'Pro tips generator'),
          ],
        ),
      ),
    );
  }
}

Widget _buildFeatureButton(
    BuildContext context, screenColorScheme, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const UsePromptWidget(),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: screenColorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: screenColorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: CustomTextStyles.headlineMedium.fontSize,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    ),
  );
}

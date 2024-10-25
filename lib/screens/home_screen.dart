import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/chat_screen.dart';
import 'package:jarvis_ai/widgets/shared/chat_input_widget.dart';
import 'package:jarvis_ai/widgets/shared/model_selector_widget.dart';

import '../helper/CustomColors.dart';
import '../helper/CustomTextStyles.dart';
import '../widgets/app_drawer_widget.dart';
import '../widgets/prompt_library_popup_widget.dart';
import '../widgets/use_prompt_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
  String selectedModel = 'GPT-3.5 Turbo'; // Default selected model

  // Callback function to update the selected model
  void updateSelectedModel(String newModel) {
    setState(() {
      selectedModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.menu_sharp,
            color: CustomColors.textDarkGrey,
            size: CustomTextStyles.headlineLarge.fontSize),
        onPressed: () {
          Scaffold.of(context).openDrawer();
          //FocusScope.of(context).unfocus();
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
                backgroundColor: CustomColors.cardColor,
                overlayColor: Colors.transparent,
              ),
              icon: Icon(Icons.water_drop_outlined,
                  color: CustomColors.textHyperlink),
              label: Text(
                '30',
                style: TextStyle(
                  color: CustomColors.textLightGrey,
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
                  color: CustomColors.textHyperlink,
                  size: CustomTextStyles.captionMedium.fontSize),
              iconAlignment: IconAlignment.end,
              label: Text(
                'Upgrade',
                style: TextStyle(
                  color: CustomColors.textHyperlink,
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
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('👋',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: CustomTextStyles.titleSmall.fontSize,
                )),
            SizedBox(height: 8),
            Text('Hi, good afternoon!',
                style: TextStyle(
                  color: CustomColors.textDarkGrey,
                  fontWeight: FontWeight.normal,
                  fontSize: CustomTextStyles.titleSmall.fontSize,
                )),
            const SizedBox(height: 8),
            Text(
              "I'm YourAI, your personal assistant.",
              style: TextStyle(
                color: CustomColors.textDarkGrey,
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
                      color: CustomColors.textLightGrey,
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
                        color: CustomColors.textHyperlink,
                        fontSize: CustomTextStyles.bodyLarge.fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFeatureButton(context, 'Grammar corrector'),
            _buildFeatureButton(context, 'Essay Improver'),
            _buildFeatureButton(context, 'Instagram post Generator'),
            _buildFeatureButton(context, 'Pro tips generator'),
          ],
        ),
      ),
    );
  }
}

Widget _buildFeatureButton(BuildContext context, String text) {
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
          color: CustomColors.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: CustomColors.textDarkGrey,
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

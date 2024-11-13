import 'package:flutter/material.dart';

import '../widgets/model_selector_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedModel = 'GPT-3.5 Turbo';

  void updateSelectedModel(String newModel) {
    setState(() {
      selectedModel = newModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset('assets/images/ic_menu.png', height: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ModelSelector(
              selectedModel: selectedModel,
              onModelChanged: updateSelectedModel,
            ),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
            ),
            icon: Icon(Icons.water_drop_outlined,
                color: screenColorScheme.secondary),
            label: Text(
              '30',
              style: TextStyle(
                color: screenColorScheme.onSecondary,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.rocket_launch,
            color: Colors.grey.shade50,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

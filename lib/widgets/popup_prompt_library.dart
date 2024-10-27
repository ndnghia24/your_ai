import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/shared/input_widget.dart';

import '../helper/CustomTextStyles.dart';
import 'popup_new_prompt.dart';
import 'popup_prompt_detail.dart';
import 'widget_use_prompt.dart';

class TestPromptLibrary extends StatelessWidget {
  const TestPromptLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Modal Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => const FractionallySizedBox(
                heightFactor: 0.75, // Chiều cao bằng nửa màn hình
                child: PromptLibraryPopupWidget(),
              ),
            );
          },
          child: const Text('Show Bottom Modal'),
        ),
      ),
    );
  }
}

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
    var screenColorScheme = Theme.of(context).colorScheme;

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
                    fontSize: CustomTextStyles.headlineMedium.fontSize,
                    fontWeight: FontWeight.bold), // Increased font size
              ),
              IconButton(
                icon: const Icon(Icons.add_circle,
                    color: Colors.blue, size: 30), // Increased icon size
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NewPromptPopupWidget(),
                  );
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
                    color: screenColorScheme.surfaceContainer,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text('My Prompt',
                              style: TextStyle(
                                  fontSize: CustomTextStyles.displaySmall
                                      .fontSize)), // Increased font size
                        ),
                      ),
                      Tab(
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text('Public Prompt',
                                style: TextStyle(
                                    fontSize: CustomTextStyles.displaySmall
                                        .fontSize)) //, Increased font size
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
          InputWidget(hintText: "Search", leftIconWidget: Icon(Icons.search)),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMyPromptList(),
                Column(
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: [
                        _buildTag('All'),
                        _buildTag('Marketing'),
                        _buildTag('Chatbot'),
                        _buildTag('Writing'),
                      ],
                    ),
                    Expanded(
                      child: _buildPublicPromptList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyPromptList() {
    return ListView(
      children: List.generate(
        3,
        (index) => ListTile(
          title: Text('Brainstorm',
              style:
                  TextStyle(fontSize: CustomTextStyles.headlineSmall.fontSize)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 28), // Increased icon size
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 28), // Increased icon size
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPublicPromptList() {
    return ListView(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Winston, the best therapist with 1...',
                    style: TextStyle(fontSize: 18)), // Increased font size
                subtitle: const Text(
                  'As the best therapist ever, Winston could ask open-ended questions and offer advice...',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16), // Increased font size
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info_outline,
                          size: 28), // Increased icon size
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const PrompDetailPopupWidget(),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_border,
                          size: 28), // Increased icon size
                      onPressed: () {},
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const UsePromptWidget(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Chip(
      label: Text(tag,
          style: const TextStyle(fontSize: 16)), // Increased font size
      backgroundColor: Colors.grey[200],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/knowledge_base_screens/knowledgebase_detail_screen.dart';
import 'package:jarvis_ai/widgets/knowledgebase/item_knowledgebase.dart';
import 'package:jarvis_ai/widgets/knowledgebase/popup_new_knowledgebase.dart';
import 'package:jarvis_ai/widgets/knowledgebase/widget_pagination.dart';
import 'package:jarvis_ai/widgets/widget_app_drawer.dart';

class KnowledgeBaseScreen extends StatelessWidget {
  const KnowledgeBaseScreen({super.key});

  void showNewKnowledgeDialog(BuildContext context) {
    // Show popup when click on "New" button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateKnowledgeBaseDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle Create Knowledge
              showNewKnowledgeDialog(context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle Knowledge base item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KnowledgeDetailScreen()),
                    );
                  },
                  child: KnowledgeBaseItem(
                    title: 'Chat bot',
                    description:
                        'You are my chat bot to test create chat bot feature. When I ask you any question, you answer start with "Hello Nhân Dzai..."',
                    units: 1,
                    size: '132.00 Bytes',
                    editTime: '9/10/2024 08:46:41',
                  ),
                ),
                KnowledgeBaseItem(
                  title: 'KB 01',
                  description: '',
                  units: 1,
                  size: '526.00 Bytes',
                  editTime: '17/10/2024 14:44:46',
                ),
              ],
            ),
          ),
          PaginationWidget(),
        ],
      ),
    );
  }
}

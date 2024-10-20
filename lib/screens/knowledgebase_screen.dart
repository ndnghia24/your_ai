import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/knowledgebase_detail_screen.dart';
import 'package:jarvis_ai/widgets/knowledgebase/knowledgebase_item.dart';
import 'package:jarvis_ai/widgets/knowledgebase/new_knowledgebase_popup.dart';
import 'package:jarvis_ai/widgets/knowledgebase/paginationwidget.dart';
import 'package:jarvis_ai/widgets/app_drawer_widget.dart';

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
      drawer: AppDrawerWidget(),
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
                      MaterialPageRoute(builder: (context) => KnowledgeDetailScreen()),
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




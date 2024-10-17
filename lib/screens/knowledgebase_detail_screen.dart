import 'package:flutter/material.dart';
import 'package:jarvis_ai/widgets/knowledgebase/add_unit_popup.dart';
import 'package:jarvis_ai/widgets/knowledgebase/knowledgebase_unit.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  void showAddUnitDialog(BuildContext context) {
    // Show popup when click on "Add unit" button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUnitPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat bot'),
        actions: [
          IconButton(
            icon: Icon(Icons.description),
            onPressed: () {
              // Handle Docs action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.storage, size: 40, color: Colors.orange),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chat bot', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('2 Units - 658.00 Bytes', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Add unit
                    showAddUnitDialog(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add unit'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                KnowledgeUnitItem(
                  fileName: '21120303.txt',
                  source: 'Local file',
                  size: '132.00 Bytes',
                  createTime: '9/10/2024',
                  latestUpdate: '9/10/2024',
                  isEnabled: true,
                ),
                KnowledgeUnitItem(
                  fileName: 'Week01.txt',
                  source: 'Local file',
                  size: '526.00 Bytes',
                  createTime: '17/10/2024',
                  latestUpdate: '17/10/2024',
                  isEnabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/knowledgebase_screen.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/item_knowledgebase.dart';

class KnowledgeBasePopup extends StatelessWidget {
  const KnowledgeBasePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Knowledge'),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Handle create knowledge action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KnowledgeBaseScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('Create Knowledge'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  KnowledgeBaseItem(
                    title: 'KB 01',
                    size: '526.00 Bytes',
                    date: '17/10/2024',
                    units: 1,
                    isRemovable: false,
                  ),
                  KnowledgeBaseItem(
                    title: 'Chat bot',
                    size: '132.00 Bytes',
                    date: '9/10/2024',
                    units: 1,
                    isRemovable: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

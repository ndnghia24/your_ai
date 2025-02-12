import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_file_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_website_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_slack_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_confluence_screen.dart';

class AddUnitPopup extends StatelessWidget {
  final String knowledgeBaseId;
  const AddUnitPopup({super.key, required this.knowledgeBaseId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add unit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text('Local files'),
              subtitle: Text('Upload pdf, docx,...'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UploadFileScreen(knowledgeId: knowledgeBaseId)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Website'),
              subtitle: Text('Connect Website to get data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UploadWebsiteScreen(knowledgeId: knowledgeBaseId)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Slack'),
              subtitle: Text('Connect Slack to get data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UploadSlackScreen(knowledgeId: knowledgeBaseId)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Confluence'),
              subtitle: Text('Connect Confluence to get data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UploadConfluenceScreen(knowledgeId: knowledgeBaseId)),
                );
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

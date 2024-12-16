import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_file_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/upload_website_screen.dart';

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadFileScreen(knowledgeId: knowledgeBaseId,)),
                );
              },
              child: ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Local files'),
                subtitle: Text('Upload pdf, docx,...'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Website'),
              subtitle: Text('Connect Website to get data'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadWebsiteScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Github repositories'),
              subtitle: Text('Connect Github repositories to get data'),
              onTap: () {
                // Handle action here
              },
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Gitlab repositories'),
              subtitle: Text('Connect Gitlab repositories to get data'),
              onTap: () {
                // Handle action here
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud),
              title: Text('Google drive'),
              subtitle: Text('Connect Google drive to get data'),
              onTap: () {
                // Handle action here
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Slack'),
              subtitle: Text('Connect Slack to get data'),
              onTap: () {
                // Handle action here
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

import 'package:flutter/material.dart';

class CreateKnowledgeBaseDialog extends StatelessWidget {
  const CreateKnowledgeBaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storage, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Knowledge name',
                labelStyle: TextStyle(color: Colors.red),
                hintText: 'Enter knowledge name',
                counterText: "0 / 50",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLength: 50,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Knowledge description',
                hintText: 'Enter knowledge description',
                counterText: "0 / 2000",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 5,
              maxLength: 2000,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle confirm action
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
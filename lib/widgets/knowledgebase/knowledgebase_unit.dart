import 'package:flutter/material.dart';

class KnowledgeUnitItem extends StatelessWidget {
  final String fileName;
  final String source;
  final String size;
  final String createTime;
  final String latestUpdate;
  final bool isEnabled;

  const KnowledgeUnitItem({super.key, 
    required this.fileName,
    required this.source,
    required this.size,
    required this.createTime,
    required this.latestUpdate,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.insert_drive_file, size: 40, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fileName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(source),
                  Text(size),
                  Text('Create Time: $createTime'),
                  Text('Latest Update: $latestUpdate'),
                ],
              ),
            ),
            Column(
              children: [
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    // Handle toggle action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle delete action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
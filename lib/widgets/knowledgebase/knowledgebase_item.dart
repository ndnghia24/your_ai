import 'package:flutter/material.dart';

class KnowledgeBaseItem extends StatelessWidget {
  final String title;
  final String description;
  final int units;
  final String size;
  final String editTime;

  const KnowledgeBaseItem({super.key, 
    required this.title,
    required this.description,
    required this.units,
    required this.size,
    required this.editTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.storage, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (description.isNotEmpty) Text(description),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Units: $units'),
                Text('Size: $size'),
              ],
            ),
            SizedBox(height: 5),
            Text('Edit time: $editTime'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete action
          },
        ),
      ),
    );
  }
}
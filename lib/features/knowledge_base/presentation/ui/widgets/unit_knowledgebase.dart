import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/unit_model.dart';

class KnowledgeUnitItem extends StatelessWidget {
  final UnitModel unit;
  final void Function(UnitModel unit) onDelete;

  const KnowledgeUnitItem({
    super.key,
    required this.unit,
    required this.onDelete,
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
                  Text(unit.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // Text(source),
                  // Text(size),
                  // Text('Create Time: $createTime'),
                  // Text('Latest Update: $latestUpdate'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle delete action
                onDelete(unit);
              },
            ),
          ],
        ),
      ),
    );
  }
}

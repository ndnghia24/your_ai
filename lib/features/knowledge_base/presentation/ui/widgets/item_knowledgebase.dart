import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';

final getIt = GetIt.instance;
class KnowledgeBaseItem extends StatelessWidget {
  final KnowledgeBase knowledgeBase;
  final void Function(KnowledgeBase) onTapItem;

  final void Function(KnowledgeBase) onDelete;

  const KnowledgeBaseItem({super.key, 
    required this.knowledgeBase,
    required this.onDelete,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem(knowledgeBase);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.storage, color: Colors.white),
          ),
          title: Text(knowledgeBase.knowledgeName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (knowledgeBase.description.isNotEmpty) Text(knowledgeBase.description),
              SizedBox(height: 5),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Handle delete action
              onDelete(knowledgeBase);
            },
          ),
        ),
      ),
    );
  }
}
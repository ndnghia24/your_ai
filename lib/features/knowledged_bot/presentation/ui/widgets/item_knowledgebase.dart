  import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/knowledge_model.dart';

  class KnowledgeBaseItem extends StatelessWidget {
    final Knowledge knowledge;
    final void Function(Knowledge knowledge) onAttach;
    final void Function(Knowledge knowledge) onDetach;

    const KnowledgeBaseItem({
      super.key,
      required this.knowledge,
      required this.onAttach,
      required this.onDetach,
    });

    @override
    Widget build(BuildContext context) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.storage, color: Colors.white),
          ),
          title: Text(knowledge.knowledgeName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    Text('${knowledge.numUnits} unit', overflow: TextOverflow.ellipsis),
            ],
          ),
          trailing: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: knowledge.isImported ? Colors.red : Colors.blue,
                ),
                onPressed: () {
                  // Handle add/remove action
                  if (knowledge.isImported) {
                  onDetach(knowledge);
                  } else {
                  onAttach(knowledge);
                  }
                },
                child: Text(
                  knowledge.isImported ? 'Remove' : 'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                ),
        ),
      );
    }
  }

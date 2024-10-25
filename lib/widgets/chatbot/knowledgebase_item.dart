  import 'package:flutter/material.dart';

  class KnowledgeBaseItem extends StatelessWidget {
    final String title;
    final String size;
    final String date;
    final int units;
    final bool isRemovable;

    const KnowledgeBaseItem({
      super.key,
      required this.title,
      required this.size,
      required this.date,
      required this.units,
      this.isRemovable = false,
    });

    @override
    Widget build(BuildContext context) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.storage, color: Colors.white),
          ),
          title: Text(title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$units unit', overflow: TextOverflow.ellipsis),
              Text(size, overflow: TextOverflow.ellipsis),
              Text(date),
            ],
          ),
          trailing: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: isRemovable ? Colors.red : Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  // Handle add/remove action
                },
                icon: Icon(isRemovable ? Icons.remove : Icons.add),
                color: Colors.white,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ),
      );
    }
  }

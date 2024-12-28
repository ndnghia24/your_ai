import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyField extends StatelessWidget {
  final String label;
  final String value;
  const CopyField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: value));
        },
      ),
    );
  }
}
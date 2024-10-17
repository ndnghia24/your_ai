import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Handle previous page action
            },
          ),
          Text('1'),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              // Handle next page action
            },
          ),
        ],
      ),
    );
  }
}
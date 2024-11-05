import 'package:flutter/material.dart';

class MySquareTile extends StatelessWidget {
  final String imgPath;
  final void Function()? onTap;
  const MySquareTile({super.key, required this.imgPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200),
          child: Image.asset(imgPath, height: 40)),
    );
  }
}

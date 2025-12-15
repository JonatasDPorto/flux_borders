import 'package:flutter/material.dart';

class DemoBox extends StatelessWidget {
  const DemoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: const Color(0xFF1E1E1E),
      alignment: Alignment.center,
      child: const Text("Content", style: TextStyle(color: Colors.white54)),
    );
  }
}

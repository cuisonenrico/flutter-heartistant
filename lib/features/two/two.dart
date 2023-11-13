import 'package:flutter/material.dart';

class Two extends StatelessWidget {
  const Two({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text("Page Two"),
      ),
    );
  }
}

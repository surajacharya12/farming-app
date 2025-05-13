import 'package:flutter/material.dart';

class Farming extends StatefulWidget {
  const Farming({super.key});

  @override
  State<Farming> createState() => _FarmingState();
}

class _FarmingState extends State<Farming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: const Center(
        child: Text('No new farming yet', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

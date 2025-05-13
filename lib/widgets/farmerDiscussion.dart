import 'package:flutter/material.dart';

class Farmerdiscussion extends StatefulWidget {
  const Farmerdiscussion({super.key});

  @override
  State<Farmerdiscussion> createState() => _FarmerdiscussionState();
}

class _FarmerdiscussionState extends State<Farmerdiscussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Discussion'),
        backgroundColor: Colors.green,
      ),
      body: const Center(child: Text('Farmer Discussion Content Here')),
    );
  }
}

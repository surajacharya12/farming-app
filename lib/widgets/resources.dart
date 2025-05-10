import 'package:flutter/material.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'No new resources available.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

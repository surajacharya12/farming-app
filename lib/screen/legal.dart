import 'package:flutter/material.dart';

class Legal extends StatefulWidget {
  const Legal({super.key});

  @override
  State<Legal> createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: const Center(
        child: Text(
          'No new legal content available yet.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

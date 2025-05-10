import 'package:flutter/material.dart';

class Crops extends StatefulWidget {
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: const Center(
        child: Text('No new crops today', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

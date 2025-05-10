import 'package:flutter/material.dart';

class Crowdfunding extends StatefulWidget {
  const Crowdfunding({super.key});

  @override
  State<Crowdfunding> createState() => _CrowdfundingState();
}

class _CrowdfundingState extends State<Crowdfunding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crowdfunding'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'No new crowdfunding projects available.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

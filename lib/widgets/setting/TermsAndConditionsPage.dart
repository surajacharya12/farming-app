import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'These are the terms and conditions for using our app. '
            'By accessing or using the app, you agree to be bound by these terms. '
            '\n\nYou agree not to misuse the services. '
            'You may not attempt to hack, reverse engineer, or exploit the app.'
            '\n\nWe reserve the right to modify these terms at any time.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

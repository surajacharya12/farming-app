import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'This is the privacy policy of your app. '
            'We are committed to protecting your personal data and ensuring your privacy. '
            'We collect data only to improve the user experience. '
            '\n\nWe do not share your data with third parties without consent.\n\n'
            'For more information, contact privacy@yourwebsite.com.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

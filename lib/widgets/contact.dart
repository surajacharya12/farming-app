import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: const Center(
        child: Text(
          'For inquiries, please contact us at:\n\nEmail: contact@yourwebsite.com\n\nPhone: +1 (123) 456-7890',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Farmerdiscussion extends StatelessWidget {
  const Farmerdiscussion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Discussion'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your data length
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Discussion Topic $index'),
            subtitle: Text('Discussion details for topic $index'),
            onTap: () {
              // Handle tap event
            },
          );
        },
      ),
    );
  }
}

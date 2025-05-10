import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabasePathScreen extends StatelessWidget {
  const DatabasePathScreen({super.key});

  Future<String> getDatabasePath() async {
    final directory =
        await getApplicationDocumentsDirectory(); // Use a writable directory
    final dbPath = join(
      directory.path,
      'app_record.db',
    ); // Replace with your database name
    return dbPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Path')),
      body: Center(
        child: FutureBuilder<String>(
          future: getDatabasePath(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Database Path: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}

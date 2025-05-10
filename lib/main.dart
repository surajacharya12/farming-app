// lib/main.dart

import 'package:flutter/material.dart';
import 'package:farmer_app/screen/login.dart';
import 'package:farmer_app/SQLite/sqlite.dart';
import 'package:farmer_app/screen/home.dart';
import 'package:farmer_app/widgets/language.dart'; // Import the language helper

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database and insert dummy data
  final dbHelper = DatabaseHelper();
  await dbHelper.initDB();
  await dbHelper.insertDummyData();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US'); // Default locale

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 21, 200, 27),
        ),
      ),
      locale: _locale, // Set the locale here
      home: LoginScreen(),
    );
  }
}

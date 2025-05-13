// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ✅ Import Riverpod
import 'package:krishi_sathi/screen/login.dart';
import 'package:krishi_sathi/SQLite/sqlite.dart';
import 'package:krishi_sathi/screen/home.dart';
import 'package:krishi_sathi/widgets/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();
  await dbHelper.initDB();
  await dbHelper.insertDummyData();

  runApp(
    const ProviderScope(
      // ✅ Wrap the app with ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');

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
      locale: _locale,
      home: const LoginScreen(),
    );
  }
}

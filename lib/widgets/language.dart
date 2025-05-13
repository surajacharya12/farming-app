// lib/widgets/language.dart

import 'package:flutter/material.dart';
import 'package:krishi_sathi/main.dart'; // Import the main app file

class LanguageHelper {
  // Method to change language
  static void changeLanguage(BuildContext context, String languageCode) {
    Locale newLocale;
    switch (languageCode) {
      case 'en':
        newLocale = const Locale('en', 'US');
        break;
      case 'ne':
        newLocale = const Locale('ne', 'NP');
        break;
      default:
        newLocale = const Locale('en', 'US');
    }

    // Finding the MyAppState and calling setLocale on it
    final MyAppState? myAppState =
        context.findAncestorStateOfType<MyAppState>();
    myAppState?.setLocale(newLocale); // Set the new locale
  }
}

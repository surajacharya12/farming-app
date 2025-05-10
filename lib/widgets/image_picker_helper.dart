// lib/helpers/image_picker_helper.dart

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

Future<File?> pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  // Show dialog to choose between Camera and Gallery
  return await showDialog<File>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(
                  context,
                  await picker.pickImage(source: ImageSource.camera),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(
                  context,
                  await picker.pickImage(source: ImageSource.gallery),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

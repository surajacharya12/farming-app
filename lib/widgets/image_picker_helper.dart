import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

Future<File?> pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  return showDialog<File>(
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
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                Navigator.pop(context, image != null ? File(image.path) : null);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                Navigator.pop(context, image != null ? File(image.path) : null);
              },
            ),
          ],
        ),
      );
    },
  );
}

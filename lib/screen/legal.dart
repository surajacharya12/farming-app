import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';

class Legal extends StatefulWidget {
  const Legal({super.key});

  @override
  State<Legal> createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  PdfControllerPinch? _pdfController;
  File? _pdfFile;
  final TextEditingController _textController = TextEditingController();

  // Dummy method for handling Q&A (you can replace with real AI integration)
  Future<String> handleUserQuestion(String question) async {
    // Here you could call OpenAI API, your backend, etc.
    return 'This is a dummy response to: "$question"';
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        _pdfFile = file;
        _pdfController = PdfControllerPinch(
          document: PdfDocument.openFile(file.path),
        );
      });
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: pickPdf,
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload PDF"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ),
          Expanded(
            child:
                _pdfController != null
                    ? PdfViewPinch(controller: _pdfController!)
                    : const Center(
                      child: Text(
                        'No PDF selected yet.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Type your question...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                final userInput = _textController.text.trim();
                if (userInput.isNotEmpty) {
                  _textController.clear();
                  final response = await handleUserQuestion(userInput);
                  // You can show this response in a snackbar, dialog, or future chat UI
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text("AI Response"),
                          content: Text(response),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                  );
                }
              },
              child: CircleAvatar(
                backgroundColor:
                    _textController.text.trim().isNotEmpty
                        ? Colors.blue.shade800
                        : Colors.grey.shade400,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

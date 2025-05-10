import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

// Replace this with your actual key or better, load it securely.
const openAIAPIKey =
    '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';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http
          .post(
            Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $openAIAPIKey',
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {
                  'role': 'user',
                  'content':
                      'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 15));

      print('isArtPromptAPI status: ${res.statusCode}');
      print('isArtPromptAPI body: ${res.body}');

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'].trim();

        if (content.toLowerCase().contains('yes')) {
          return await dallEAPI(prompt);
        } else {
          return await chatGPTAPI(prompt);
        }
      }

      return 'An internal error occurred (Status: ${res.statusCode})';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http
          .post(
            Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $openAIAPIKey',
            },
            body: jsonEncode({"model": "gpt-3.5-turbo", "messages": messages}),
          )
          .timeout(const Duration(seconds: 15));

      print('chatGPTAPI status: ${res.statusCode}');
      print('chatGPTAPI body: ${res.body}');

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'].trim();
        messages.add({'role': 'assistant', 'content': content});
        return content;
      }

      return 'An internal error occurred (Status: ${res.statusCode})';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http
          .post(
            Uri.parse('https://api.openai.com/v1/images/generations'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $openAIAPIKey',
            },
            body: jsonEncode({
              'prompt': prompt,
              'n': 1,
              'model': 'dall-e-2', // or 'dall-e-3' if available
            }),
          )
          .timeout(const Duration(seconds: 15));

      print('dallEAPI status: ${res.statusCode}');
      print('dallEAPI body: ${res.body}');

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'].trim();
        messages.add({'role': 'assistant', 'content': imageUrl});
        return imageUrl;
      }

      return 'An internal error occurred (Status: ${res.statusCode})';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}

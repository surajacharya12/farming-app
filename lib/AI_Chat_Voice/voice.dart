import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:krishi_sathi/AI_Chat_Voice/pallete.dart';

class Voice extends StatefulWidget {
  const Voice({super.key});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  final FlutterTts _flutterTts = FlutterTts();

  // NEW: Track if send button can be enabled
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash-exp',
      apiKey: 'AIzaSyCOEjEAsk-DEDvBBO9fz0sQnJ6DOR9DJ8M',
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 512,
      ),
    );
    _chatSession = _model.startChat(history: []);
    _speech = stt.SpeechToText();

    // NEW: Add listener to update send button state when input text changes
    _controller.addListener(() {
      setState(() {
        _canSend = _controller.text.trim().isNotEmpty;
      });
    });
  }

  Future<void> _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': input});
    });
    _controller.clear();

    try {
      final response = await _chatSession.sendMessage(Content.text(input));
      final reply = response.text ?? 'No response from Gemini.';

      setState(() {
        _messages.add({'sender': 'bot', 'text': reply});
      });

      await _speak(reply);
    } catch (e) {
      const errorText = 'Error fetching response.';
      setState(() {
        _messages.add({'sender': 'bot', 'text': errorText});
      });
      await _speak(errorText);
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) async {
          if (status == 'notListening' || status == 'done') {
            setState(() => _isListening = false);
            _speech.stop();

            if (_controller.text.trim().isNotEmpty) {
              await _sendMessage();
            }
          }
        },
        onError: (error) {
          setState(() => _isListening = false);
          debugPrint("Speech error: ${error.errorMsg}");
        },
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
            });
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 3),
          partialResults: true,
          localeId: 'en_US',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();

      if (_controller.text.trim().isNotEmpty) {
        await _sendMessage();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int start = 200;
    int delay = 200;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Hamro Ai Sathi'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 123,
              width: 123,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Pallete.assistantCircleColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/virtualAssistant.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message['sender'] == 'user';
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      if (!isUser)
                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.android,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      if (!isUser) const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isUser
                                    ? const Color.fromARGB(255, 72, 196, 163)
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft:
                                  isUser
                                      ? const Radius.circular(12)
                                      : Radius.zero,
                              bottomRight:
                                  isUser
                                      ? Radius.zero
                                      : const Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              fontFamily: 'Cera Pro',
                              fontSize: 16,
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 12 : 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type or speak...',
                      hintStyle: const TextStyle(fontFamily: 'Cera Pro'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                // UPDATED Send button with enable/disable logic
                CircleAvatar(
                  backgroundColor:
                      _canSend ? Colors.lightBlue : Colors.grey.shade400,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _canSend ? _sendMessage : null,
                  ),
                ),
                const SizedBox(width: 8),
                ZoomIn(
                  delay: Duration(milliseconds: start + 3 * delay),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 138, 229, 174),
                    child: IconButton(
                      onPressed: _listen,
                      icon: Icon(_isListening ? Icons.stop : Icons.mic),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

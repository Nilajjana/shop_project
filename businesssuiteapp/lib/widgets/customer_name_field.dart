import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CustomerNameField extends StatefulWidget {
  const CustomerNameField({super.key});

  @override
  State<CustomerNameField> createState() => _CustomerNameFieldState();
}

class _CustomerNameFieldState extends State<CustomerNameField> {
  final TextEditingController _controller = TextEditingController();

  final SpeechToText _speech = SpeechToText();

  bool _isListening = false;

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();

      if (!available) return;

      setState(() {
        _isListening = true;
      });

      _speech.listen(
        listenOptions: SpeechListenOptions(
          partialResults: true,
        ),
        onResult: (result) {
          String spoken = result.recognizedWords;

          spoken = spoken.replaceAllMapped(
            RegExp(r'\bspace\b', caseSensitive: false),
                (match) => " ",
          );

          spoken = spoken.replaceAll(" ", "");

          _controller.text = spoken.toUpperCase();

          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        },
      );
    } else {
      _speech.stop();

      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: "Customer Name",
        hintText: "Enter or speak customer name",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
          ),
          onPressed: _listen,
        ),
      ),
    );
  }
}
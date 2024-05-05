import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToP extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechToP> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'ahmed': HighlightedWord(
      onTap: () => print('ahmed'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'it': HighlightedWord(
      onTap: () => print('it'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'share': HighlightedWord(
      onTap: () => print('share'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'اضغط زر التسجيل';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول الصوت إلى نص',
          style: TextStyle(
            fontSize: 18,
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 231, 231, 231),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 136, 146, 128),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        // endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
            color: Colors.white60,
          ),
          backgroundColor: Color.fromARGB(255, 136, 146, 128),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(
            vertical: (300),
            horizontal: (120),
          ),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: TextStyle(
              fontSize: 20,
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(190, 60, 50, 61),
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

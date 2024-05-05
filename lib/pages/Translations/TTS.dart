import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

// Assign the API key directly
String EL_API_KEY = '3238d3b15b7698baae24e7023858acde';

class TextToP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TTSHomePage();
  }
}

class TTSHomePage extends StatefulWidget {
  @override
  _TTSHomePageState createState() => _TTSHomePageState();
}

class _TTSHomePageState extends State<TTSHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  final player = AudioPlayer();
  bool _isLoadingVoice = false;
  String selectedVoice = 'kocaQTZy4RKAwDJHzLig'; // Default to female voice

  @override
  void dispose() {
    _textFieldController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> playTextToSpeech(String text) async {
    setState(() {
      _isLoadingVoice = true;
    });

    String url = 'https://api.elevenlabs.io/v1/text-to-speech/$selectedVoice';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'audio/mpeg',
        'xi-api-key': EL_API_KEY,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "text": text,
        "model_id": "eleven_multilingual_v2",
        "voice_settings": {"stability": .15, "similarity_boost": .75}
      }),
    );

    setState(() {
      _isLoadingVoice = false;
    });

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await player.setAudioSource(MyCustomSource(bytes));
      player.play();
    } else {
      throw Exception('Failed to load audio');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حول النص إلى صوت',
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
      body: Align(
        alignment: Alignment.centerRight, // Align the content to the right
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70),
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  labelText: 'أكتب النص المُراد تحويله',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(190, 60, 50, 61),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Color.fromARGB(255, 136, 146, 128)), // Line color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 136, 146, 128)), // Focused line color
                  ),
                ),
                cursorColor: Colors.white, // Mouse cursor color
              ),
              SizedBox(height: 16.0),
              Text(
                'اختر الصوت',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: selectedVoice,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedVoice = newValue!;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Color.fromARGB(255, 136, 146, 128)), // Line color
                  ),
                ),
                items: <String>[
                  'kocaQTZy4RKAwDJHzLig', // Female voice
                  'J9baCpTmE4JYgpt9vpt1', // Male voice
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.centerRight,
                    value: value,
                    child: Text(
                      value == 'kocaQTZy4RKAwDJHzLig' ? 'أنثى' : 'ذكر',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(190, 60, 50, 61),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 70),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 136, 146, 128), // Button background color
                ),
                onPressed: () {
                  print("button pressed");
                  playTextToSpeech(_textFieldController.text);
                },
                child: _isLoadingVoice
                    ? LinearProgressIndicator()
                    : Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;

  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import needed for WriteBuffer
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignTo extends StatefulWidget {
  final List<CameraDescription> cameras;
  const SignTo({Key? key, required this.cameras}) : super(key: key);

  @override
  _SignToState createState() => _SignToState();
}

class _SignToState extends State<SignTo> {
  CameraController? _controller;
  bool _isDetecting = false;
  String translatedText = "Waiting..."; // Default text for display

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.stopImageStream().then((_) {
      _controller?.dispose();
    }).catchError((e) {
      print("Failed to stop the camera stream: $e");
    }).whenComplete(() {
      super.dispose();
    });
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      final CameraDescription firstCamera = widget.cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.medium);
      await _controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _runModel();
      }).catchError((e) {
        print('Camera initialization error: $e');
      });
    } else {
      print('No cameras available');
    }
  }

  void _runModel() {
    if (_controller != null) {
      _controller!.startImageStream((CameraImage img) async {
        if (!_isDetecting) {
          _isDetecting = true;
          try {
            List<int> imgBytes = _concatenatePlanes(img.planes);
            await _detectObjects(imgBytes);
          } finally {
            if (mounted) {
              setState(() => _isDetecting = false);
            }
          }
        }
      });
    }
  }

  List<int> _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  Future<void> _detectObjects(List<int> imgBytes) async {
    String base64Image = base64Encode(Uint8List.fromList(imgBytes));
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.8:5000/predict'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'image': base64Image}),
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (!mounted) return;
        setState(() {
          translatedText =
              body['prediction']['gesture'] ?? "No gesture detected";
        });
      } else {
        if (!mounted) return;
        setState(() {
          translatedText = "Failed to detect gestures: ${response.statusCode}";
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        translatedText = "Exception: $e";
      });
      print('Error detecting gestures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ترجم لغة الإشارة',
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
      body: _controller == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 136, 146, 128),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    translatedText,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: GoogleFonts.cairo().fontFamily),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:beyan_a/pages/Translations/STT.dart';
import 'package:beyan_a/pages/Translations/TTS.dart';
import 'package:beyan_a/pages/Translations/signTo.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homeP extends StatefulWidget {
  homeP({Key? key}) : super(key: key);

  @override
  _homePState createState() => _homePState();
}

class _homePState extends State<homeP> {
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    initializeCameras();
  }

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 136, 146, 128),
        leading: Container(),
        centerTitle: true,
        title: Image.asset(
          "assets/images/beyan.png",
          height: 80,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                ' \n ! ياهـلا',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 10),
              Text(
                'بيان برنامج سعودي يخليك تتواصل بالصوت والصورة مع الصم والبكم باستعمالك تقنيات الذكاء الاصطناعي\n\nجرب خدماتنا',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ContainerCard(
                image: AssetImage('assets/images/STT2.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpeechToP()),
                  );
                },
              ),
              SizedBox(height: 20),
              ContainerCard(
                image: AssetImage('assets/images/TTS2.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TextToP()),
                  );
                },
              ),
              SizedBox(height: 20),
              ContainerCard(
                image: const AssetImage('assets/images/rec2.png'),
                onPressed: cameras.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignTo(cameras: cameras)),
                        );
                      }
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('No Cameras Found'),
                            content: const Text(
                                'No cameras are available on this device.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerCard extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onPressed;

  const ContainerCard({
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 370,
        height: 230,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 234, 236, 234),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image(image: image, width: 240, height: 110),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: onPressed,
              child: Text(
                'جربها',
                style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Color.fromARGB(225, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

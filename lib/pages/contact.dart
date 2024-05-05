import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class conctactP extends StatefulWidget {
  conctactP({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _contactPState();
}

class _contactPState extends State<conctactP> {
  void _launchTwitterURL() async {
    const url =
        'https://twitter.com/daghh_'; // Replace with your Twitter username
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              const SizedBox(height: 50),
              Text(
                '  أصدقائنا في بيان',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
              ),
              Text(
                "! يسعدنا تواصلكم معنا",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 86, 65, 88),
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(
                        Icons.account_circle_sharp,
                        size: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'غادة البدراني',
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 5),
                      Text("X: @daghh_"),
                    ]),
                    Column(children: <Widget>[
                      Icon(
                        Icons.account_circle_sharp,
                        size: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'شهد الحربي',
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 5),
                      Text("X: @ShahadHazz"),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //body: Center(
      // child: ElevatedButton(
      // onPressed: _launchTwitterURL,
      //child: Text('Open Twitter Profile'),
      //),
      //),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class aboutP extends StatefulWidget {
  aboutP({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _aboutPState();
}

class _aboutPState extends State<aboutP> {
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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              SizedBox(height: 50),
              Text(
                'نهدف في بيان',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
              ),
              Text(
                "أن نجعل التواصل ميسرًا لمستخدم التطبيق",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 86, 65, 88),
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'نهتم في بيان',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 50, 61),
                ),
              ),
              Text(
                "أن نجعل لغة الإشارة لغة أساسية الإستعمال",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 86, 65, 88),
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Text(
                      " حسابات قد تهمك",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 86, 65, 88),
                        fontFamily: GoogleFonts.cairo().fontFamily,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Color.fromARGB(255, 211, 207, 194),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: <Widget>[
                          Icon(
                            Icons.account_circle_sharp,
                            size: 40,
                          ),
                          Text(
                            'الجمعية السعودية \n للإعاقة السمعية',
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("X: @Shiorgsa"),
                        ]),
                        Column(children: <Widget>[
                          Icon(
                            Icons.account_circle_sharp,
                            size: 40,
                          ),
                          Text(
                            'بيان',
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("X: @Beyan_SA"),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:beyan_a/Nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/cover.png', // Path to your background image asset
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 350),
                Text('غنِيّ عن البيان: واضح تمامًا وبديهيّ',
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ))),
                SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
                  child: Text(
                    "ابدأ التجربة",
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    )),
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

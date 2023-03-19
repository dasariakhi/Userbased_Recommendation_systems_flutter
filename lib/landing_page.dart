import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:recommendationsystems/login/auth_login.dart';

class Landing_Page extends StatelessWidget {
  const Landing_Page({super.key});

  @override
  Widget build(BuildContext context) {
    late Size size;

    size = MediaQuery.of(context).size;

    const colorizeColors = [
      Colors.orange,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Pacifico',
    );
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/main.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome To',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Recommendations Systems',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/auth");
                      },
                      child: Container(
                        height: size.height * .06,
                        width: size.width * .06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("or",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/register"),
                      child: Container(
                        height: size.height * .06,
                        width: size.width * .06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recommendationsystems/login/auth_login.dart';
import 'package:recommendationsystems/login/login.dart';
import 'package:recommendationsystems/myhome_page.dart';

class RegisterPage extends StatefulWidget {
  static const routename = "/register";

  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

late Size size;
final idController = TextEditingController();
final passController = TextEditingController();
final repassController = TextEditingController();
@override
initState() {
  idController.clear();
  passController.clear();
  repassController.clear();
  print("initState Called");
}

class _RegisterPageState extends State<RegisterPage> {
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void signUp() async {
    showDialog(
        context: context,
        builder: (content) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (passController.text == repassController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: idController.text,
          password: passController.text,
        );

        Navigator.pop(context);

        // Navigator.pushNamed(context, "/auth");
      } else {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Both passwords don't match"),
                content: Text("Invalid credentials"),
              );
            });
        //print("password dont match");
      }

      Navigator.pop(context);
      Navigator.pushNamed(context, "/auth");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const AuthLogin()),
      // );
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(error.code),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * .06),
                    height: size.height * .85,
                    width: size.width * .45,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        // logo
                        // Image.asset(
                        //   "assets/images/icon.jpg",
                        //   height: size.width * 0.5,
                        //   width: size.width * 0.5,
                        // ),

                        // SizedBox(height: 50),

                        // welcome back, you've been missed!
                        Text("Recommendation Systems",
                            style: GoogleFonts.pacifico(
                              color: Colors.black,
                              fontSize: size.width * .03,
                            )),

                        const SizedBox(height: 25),
                        Text('Hey There, Enter details below!',
                            style: GoogleFonts.pacifico(
                              color: Colors.black,
                              fontSize: size.width * .01,
                            )),
                        const SizedBox(height: 15),

                        Container(
                          width: size.width * .25,
                          child: TextField(
                            controller: idController,
                            decoration: InputDecoration(
                                hintText: 'userId@rs.com',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        SizedBox(height: 15),

                        // password textfield
                        Container(
                          width: size.width * .25,
                          child: TextField(
                            controller: passController,
                            decoration: InputDecoration(
                                hintText: 'password',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),
                        SizedBox(height: 15),

                        Container(
                          width: size.width * .25,
                          child: TextField(
                            controller: repassController,
                            decoration: InputDecoration(
                                hintText: 're-enter password',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),

                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: () {
                            signUp();
                            idController.clear();
                            passController.clear();
                            repassController.clear();
                          },
                          child: Container(
                            width: size.width * .25,
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a  member?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              // onTap: widget.onTap,
                              child: const Text(
                                'Login now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
    ;
  }
}

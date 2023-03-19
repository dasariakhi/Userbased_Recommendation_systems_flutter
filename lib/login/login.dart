import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommendationsystems/myhome_page.dart';

import '../providers/provider.dart';

class Login_User extends StatefulWidget {
  static const routename = '/login';
  // final Function()? onTap;

  const Login_User({
    super.key,
  });

  @override
  State<Login_User> createState() => _Login_UserState();
}

late Size size;
final idController = TextEditingController();
final passController = TextEditingController();

class _Login_UserState extends State<Login_User> {
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void signIn() async {
    showDialog(
        context: context,
        builder: (content) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: idController.text, password: passController.text);

      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      if (error.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Invalid UserId"),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Invalid credentials"),
              );
            });
      }
    }
  }

  var _provider;
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ItemsProvider>(context);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: size.height * .15),
                  height: size.height * .7,
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

                      SizedBox(height: 50),

                      // welcome back, you've been missed!
                      Text("Recommendation Systems",
                          style: GoogleFonts.pacifico(
                            color: Colors.black,
                            fontSize: size.width * .03,
                          )),

                      const SizedBox(height: 25),

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

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          signIn();
                          idController.clear();
                          passController.clear();
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
                              "Login",
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
                            'Not a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/register");
                            },
                            // onTap: widget.onTap,
                            child: const Text(
                              'Register now',
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
        ));
    ;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recommendationsystems/login/Login_or_Register.dart';
import 'package:recommendationsystems/login/login.dart';
import 'package:recommendationsystems/myhome_page.dart';

class AuthLogin extends StatefulWidget {
  static const routename = "/auth";
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Login_User();
          }
        },
      ),
    );
  }
}

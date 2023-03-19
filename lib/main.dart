import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommendationsystems/login/auth_login.dart';
import 'package:recommendationsystems/login/login.dart';
import 'package:recommendationsystems/providers/provider.dart';
import 'package:recommendationsystems/register.dart';
import 'dart:html';
import 'landing_page.dart';
import 'login/Login_or_Register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDs91F0yOaRjSP3Yb7JrnYz5BUmGocWrq4",
          projectId: "login-c2dcc",
          storageBucket: "login-c2dcc.appspot.com",
          messagingSenderId: "348529831299",
          appId: "1:348529831299:web:1fe9dfbb95c368a7d19ab6",
          measurementId: "G-62LX8Y93V5"));

  //options: DefaultFirebaseOptions.currentPlatform,
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool showLoginPage = true;
    void togglePage() {
      showLoginPage = !showLoginPage;
    }

    return ChangeNotifierProvider(
      create: (context) => ItemsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recommendation Systems',
        home: const Landing_Page(),
        routes: {
          AuthLogin.routename: (context) => AuthLogin(),
          RegisterPage.routename: (context) => RegisterPage(),
          Login_User.routename: (context) => Login_User()
        },
      ),
    );
  }
}

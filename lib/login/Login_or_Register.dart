// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:recommendationsystems/login/login.dart';
// import 'package:recommendationsystems/myhome_page.dart';
// import 'package:recommendationsystems/register.dart';

// class LoginOrRegister extends StatefulWidget {
//   const LoginOrRegister({super.key});

//   @override
//   State<LoginOrRegister> createState() => _LoginOrRegisterState();
// }

// class _LoginOrRegisterState extends State<LoginOrRegister> {
//   bool showLoginPage = true;
//   void togglePage() {
//     setState(() {
//       showLoginPage = !showLoginPage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return Login_User(
//         onTap: togglePage,
//       );
//     } else
//       return RegisterPage(
//         onTap: togglePage,
//       );
//   }
// }

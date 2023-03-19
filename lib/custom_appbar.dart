import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommendationsystems/landing_page.dart';
import 'package:recommendationsystems/myhome_page.dart';
import 'package:recommendationsystems/providers/provider.dart';

import 'login/auth_login.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

var addData;
List<List<dynamic>> data = [];
loadAsset() async {
  final myData = await rootBundle.loadString("combined.csv");
  //print(myData);
  List<List<dynamic>> csTable = CsvToListConverter().convert(myData);
  data = csTable;
  addData.fulldata = data;
  // print(data);
  // print(addData.fulldata);
}

late Size size;

class _CustomAppBarState extends State<CustomAppBar> {
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    addData = Provider.of<ItemsProvider>(context);

    final userEmail = FirebaseAuth.instance.currentUser;
    final userId = userEmail!.email!;

    String onlyId = userId.replaceAll("@rs.com", "");

    print(onlyId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Recommendation Systems",
            style: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: size.width * .03,
            )),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false);
              },
              child: Container(
                height: size.width * .02,
                width: size.width * .05,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(child: Text("Home")),
              ),
            ),
            // GestureDetector(
            //   onTap: () async {
            //     await loadAsset();
            //   },
            //   child: Container(
            //     height: size.width * .02,
            //     width: size.width * .05,
            //     decoration: BoxDecoration(
            //         color: Colors.white54,
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //     child: Center(child: Text("About")),
            //   ),
            // ),
            SizedBox(
              width: 15,
            ),
            Container(
              height: size.width * .02,
              width: size.width * .11,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Center(child: Text(userEmail!.email!)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Landing_Page()),
                    (route) => false);
              },
              child: Container(
                height: size.width * .02,
                width: size.width * .05,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(child: Text("Logout")),
              ),
            ),
          ],
        )
      ],
    );
  }
}

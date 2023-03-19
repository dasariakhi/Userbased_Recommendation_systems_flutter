import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:recommendationsystems/myhome_page.dart';
import 'package:recommendationsystems/providers/provider.dart';

import '../ratings_for_suggestions.dart';

class SuggestionPage extends StatefulWidget {
  int suggestions;
  SuggestionPage({super.key, required this.suggestions});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

int id = 0;
Size? size;
int displaysuggestions = 1;
int displaysuggestions1 = 1;
double userrating = 0;

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  initState() {
    print(suggestions);

    if (suggestions == 0) {
      setState(() {
        suggestions = 1;
      });
    }
    print("initState Called");
  }

  var getData;
  @override
  void didChangeDependencies() {
    // print(Provider.of<ItemsProvider>(context).responseBody);
    //print("dfbfd $getData");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<ItemsProvider>(context).responseBody);
    size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Center(
            child: Container(
                height: size!.height * .8,
                width: size!.width * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white38),
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: ((context, index) => Column(
                                  children: [
                                    Container(
                                      width: size!.width * .3,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                      child: GestureDetector(
                                        onTap: (() {
                                          print(index);
                                          setState(() {
                                            id = index;
                                            getData.ratings = id;
                                            print("sacsd ${getData.ratings}");

                                            print("sdssd $id");
                                          });

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(25),
                                                    ),
                                                  ),
                                                  actions: [
                                                    // RatingForSuggestions()
                                                  ]);
                                              ;
                                            },
                                          );
                                        }),
                                        child: Text(
                                          "sd",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                )))))),
          )),
        ));
  }
}

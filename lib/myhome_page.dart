import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommendationsystems/providers/provider.dart';

import 'package:recommendationsystems/ratings_for_suggestions.dart';
import 'package:recommendationsystems/suggestion_page.dart';
import 'package:http/http.dart' as http;

import 'custom_appbar.dart';
import 'login/restaurents_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int id = 0;
late Size size;
int displaysuggestions = 1;
int displaysuggestions1 = 1;
dynamic responseBody;

String? selectedItem = 'jhc';
var _addData;
String dropdownvalue = 'Spanish';
String suggestiondropvalue = '1';
bool _suggestion = false;
// List of items in our dropdown menu
var items = [
  'Spanish',
  'Italian',
  'Latin_American',
  'Mexican',
  'Fast_Food',
  'Burgers',
  'Dessert-Ice-Cream',
  'Hot_Dogs',
  'Steaks',
  'Asian',
  'International'
];
var suggestionNumbers = ['1', '2', '3', '4', ' 5'];
int suggestions = 0;
String? userid;

class _MyHomePageState extends State<MyHomePage> {
  String _chosenValue = 'Android';
  final useridController = TextEditingController();
  final suggestionsController = TextEditingController();
  final String textFiledName = "User Id";
  final String noOFSuggestions = "No of Suggestions";
  var provider;
  var _data;
  List<List<dynamic>> _getdata = [];
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // userid = Provider.of<ItemsProvider>(context).userid;

    // var addData = Provider.of<ItemsProvider>(context);
    // print(addData.fulldata);
    super.didChangeDependencies();
  }

  List<List<dynamic>> filteredRows = [];
  bool exsiting_user = true;
  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser;
    final userId = userEmail!.email!;

    String onlyId = userId.replaceAll("@rs.com", "");
    userid = onlyId.toUpperCase();
    String userInput = userid!;
    getDataByUserID(userid!);

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("User History",
                        style: GoogleFonts.pacifico(
                          color: Colors.white,
                          fontSize: size.width * .016,
                        )),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent),
                      height: size.height * .6,
                      width: size.width * 1,
                      //   color: Colors.black,
                      child: exsiting_user
                          ? GridView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: filteredRows.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // Number of columns
                                // crossAxisSpacing: 2, // Spacing between columns
                                //mainAxisSpacing: 2, // Spacing between rows
                                childAspectRatio:
                                    3, // Aspect ratio of each child
                              ),
                              itemBuilder: (context, index) {
                                // Use the item data to create a widget for each grid cell

                                //print("lol ${filteredRows[index][1]}");
                                return Container(
                                    height: size.height * .2,
                                    width: size.width * .4,
                                    margin: const EdgeInsets.all(15.0),
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.04,
                                        right: size.width * 0.04),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white38)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: size.height * .15,
                                          width: size.width * .09,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.black),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              imageUrls[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'place id : ${_getdata[index][1]}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Overall Rating : ${_getdata[index][2]}',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Food Rating : ${_getdata[index][2]}',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Service Rating : ${_getdata[index][3].toStringAsFixed(1)}',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              })
                          : Center(
                              child: Container(
                                  child: Text(
                                "NO HISTORY FOUND",
                                style: TextStyle(color: Colors.white),
                              )),
                            )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: size.width * .05,
                      width: size.width * .35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white38),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Do you want Recommendations\n            Click button",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * .01),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // provider = userid;
                                  getRecommendedRestaurants(userid!);
                                  // print(suggestions);
                                  // _suggestion = true;
                                  // displaysuggestions1 =
                                  //     displaysuggestions;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantList(userId: userid!)),
                                  );
                                });
                              },
                              child: Container(
                                height: size.width * .03,
                                width: size.width * .1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: Center(
                                    child: Text(
                                  "               Get \n  Recommendations",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .06,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<List<List<dynamic>>> getDataByUserID(String userID) async {
    // Load the CSV file from the assets folder
    String data = await rootBundle.loadString('restaurents_visited.csv');

    // Convert CSV data to a List<List<dynamic>>
    List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

    // Filter the rows by user ID
    filteredRows = csvTable.where((row) => row[0] == userID).toList();

    print(filteredRows);
    setState(() {
      _getdata = filteredRows;
    });

    print("sfa $_getdata");
    if (_getdata.isEmpty) {
      print("dfedfs $_getdata");
      setState(() {
        exsiting_user = false;
        print(exsiting_user);
      });
    }

    return filteredRows;
  }

  Future getRecommendedRestaurants(String userid) async {
    print(userid);
    // print("im here");
    // Define the API endpoint URL
    final String apiUrl = 'http://127.0.0.1:5000/recommend';

    // Define the request body with the user ID input
    // print("im here");
    final Map<String, String> requestBody = {
      'userID': userid,
    };

    // Send a POST request to the API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body as a list of strings
      responseBody = jsonDecode(response.body);
      // Provider.of<ItemsProvider>(context).responseBody = requestBody;

      print(responseBody);
    } else {
      // If the request was not successful, throw an error
      throw Exception('Failed to load recommended restaurants');
    }
  }
}

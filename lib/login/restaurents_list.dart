import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:recommendationsystems/custom_appbar.dart';

import 'dart:math';

import 'package:recommendationsystems/login/rate.dart';
import 'package:recommendationsystems/myhome_page.dart';
import 'package:recommendationsystems/ratings_for_suggestions.dart';

import '../providers/provider.dart';

class RestaurantList extends StatefulWidget {
  final String userId;

  RestaurantList({required this.userId});

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

late Size size;
final List<String> imageUrls = [
  "images/1.jpg",
  "images/2.jpg",
  "images/3.jpg",
  "images/4.jpg",
  "images/5.jpg",
  "images/6.jpg",
  "images/7.jpg",
  "images/8.jpg",
  "images/1.jpg",
  "images/2.jpg",
  "images/1.jpg",
  "images/2.jpg",
  "images/3.jpg",
  "images/4.jpg",
  "images/5.jpg",
  "images/6.jpg",
  "images/7.jpg",
  "images/8.jpg",
  "images/1.jpg",
  "images/2.jpg",
];
final Random random = Random();

class _RestaurantListState extends State<RestaurantList> {
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    //  userid = Provider.of<ItemsProvider>(context).userid;

    // var addData = Provider.of<ItemsProvider>(context);
    // print(addData.fulldata);
    super.didChangeDependencies();
  }

  Future<List<dynamic>> _getRecommendations() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/recommend'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userID': widget.userId}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['restaurants'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _getData = Provider.of<ItemsProvider>(context);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomAppBar(),
                ),
                Container(
                  child: FutureBuilder<List<dynamic>>(
                      future: _getRecommendations(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          final List<dynamic> restaurants = snapshot.data!;
                          return Container(
                              height: size!.height * .8,
                              width: size!.width * .33,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white38),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: restaurants.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          _getData.ratings = index;
                                          _getData.resId =
                                              restaurants[index]['place'];
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             RatingForSuggestions()));
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
                                                    RatingForSuggestions(
                                                        userId: widget.userId)
                                                  ]);
                                              ;
                                            },
                                          );
                                        },
                                        child: Container(
                                            height: size!.height * 0.2,
                                            margin: const EdgeInsets.all(15.0),
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.04,
                                                right: size.width * 0.04),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: size.height * .16,
                                                  width: size.height * .16,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      imageUrls[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Restaurant id : ${restaurants[index]['place']}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Text(
                                                      //     'Restaurant id : ${restaurants[index]['rating'].toStringAsFixed(1)}',
                                                      //     style: TextStyle(
                                                      //         color: Colors
                                                      //             .white)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )

                                            // ListTile(
                                            //     title: Text(
                                            //       'Restaurant id ${restaurants[index]['place']}',
                                            //       style:
                                            //           TextStyle(color: Colors.white),
                                            //     ),
                                            //     subtitle: Text(
                                            //       'Rating: ${restaurants[index]['rating']}',
                                            //       style:
                                            //           TextStyle(color: Colors.white),
                                            //     )),
                                            ));
                                  },
                                ),
                              )));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            )));
  }
}

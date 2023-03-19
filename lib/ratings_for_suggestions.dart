import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recommendationsystems/providers/provider.dart';
import 'package:csv/csv.dart';
import 'login/rate.dart';
import 'myhome_page.dart';

// ignore: must_be_immutable
class RatingForSuggestions extends StatefulWidget {
  final String userId;
  RatingForSuggestions({super.key, required this.userId});

  @override
  State<RatingForSuggestions> createState() => _RatingForSuggestionsState();
}

class _RatingForSuggestionsState extends State<RatingForSuggestions> {
  double _userrating = 0;
  late Size size;
  final double _foodRating = 0;
  final double _serviceRating = 0;
  final double _fullRating = 0;

  @override
  void initState() {
    // var _getData = Provider.of<ItemsProvider>(context);
    // print(_getData.ratings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _getData = Provider.of<ItemsProvider>(context);

    print(_getData.ratings);
    // print(widget.indexId);

    size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 30),
      height: size.width * .2,
      width: size.width * .3,
      child: Column(
        children: [
          Text(
            "Please Give Ratings for this Restaurant ID${_getData.resId}",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 15,
          ),

          Text(
            "Food Rating",
            style: TextStyle(
              fontSize: 15,
            ),
          ),

          Container(
              //color: Colors

              child: Rate(rates: _foodRating)),
          SizedBox(
            height: 15,
          ),
          Text(
            "Service Rating",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Container(
              //color: Colors

              child: Rate(rates: _serviceRating)),
          SizedBox(
            height: 15,
          ),
          Text(
            "Overall Rating",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Container(
              //color: Colors

              child: Rate(rates: _fullRating)),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              print("final rates ${_getData.rates}");
              print("id ${widget.userId}");
              print("resid ${_getData.resId}");
              print(_getData.rates[0]);
              print(_getData.rates[1]);
              print(_getData.rates[2]);

              // _getData.writeToCsv(widget.userId, _getData.resId,
              //_getData.rates[0], _getData.rates[1], _getData.rates[2]);
              _getData.addRatings(widget.userId, _getData.resId,
                  _getData.rates[2], _getData.rates[1], _getData.rates[2]);
              Navigator.of(context).pop();
              _getData.rates.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            },
            child: Container(
              height: size.width * .025,
              width: size.width * .07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.black),
              child: Center(
                  child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          // Text("rating $userrating"),
        ],
      ),
    );
  }
}

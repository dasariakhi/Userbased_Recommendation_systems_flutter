import 'dart:convert';
import 'dart:io';
import "dart:async";
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class ItemsProvider extends ChangeNotifier {
  final List rates = [];
  var resId;
  int ratings = 0;
  String? userid;
  dynamic displaylistofdata;
  dynamic responseBody;

  get csv => null;

  Future<Map<String, dynamic>> addRatings(String userID, int placeID,
      double rating, double foodRating, double serviceRating) async {
    final url = Uri.parse('http://127.0.0.1:5000/add_rating');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userID': userID,
        'placeID': placeID,
        'rating': rating,
        'food_rating': foodRating,
        'service_rating': serviceRating,
      }),
    );

    if (response.statusCode == 200) {
      print('done');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add ratings: ${response.body}');
    }
  }

  //     'C:/Users/akhil/Desktop/flutter/recommendationsystems/assets/restaurents_visited.csv';
}

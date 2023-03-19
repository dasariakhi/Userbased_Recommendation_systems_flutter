import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class Rate extends StatefulWidget {
  double rates;
  Rate({super.key, required this.rates});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  List r = [];
  @override
  Widget build(BuildContext context) {
    var getData = Provider.of<ItemsProvider>(context);
    return Container(
        child: RatingBar.builder(
            itemCount: 3,
            minRating: 1,
            maxRating: 3,
            itemBuilder: (context, i) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            onRatingUpdate: (rating) => setState(() {
                  getData.rates.add(rating);
                  // print(r);
                })));
  }
}

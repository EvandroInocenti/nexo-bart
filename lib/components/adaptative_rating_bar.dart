// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class AdaptativeRatingBar extends StatelessWidget {
  double initialRating;
  Axis direction;
  int itemCount;
  EdgeInsetsGeometry itemPadding;
  double? itemSize;
  void Function(double) onRatingUpdate;
  bool updateOnDrag;

  AdaptativeRatingBar({
    Key? key,
    required this.direction,
    required this.itemCount,
    required this.initialRating,
    required this.itemPadding,
    required this.itemSize,
    required this.onRatingUpdate,
    required this.updateOnDrag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Text('ios')
        : RatingBar.builder(
            initialRating: initialRating,
            direction: direction,
            itemCount: itemCount,
            itemPadding: itemPadding,
            itemSize: itemSize!,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return const Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return const Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
                default:
                  return Container();
              }
            },
            onRatingUpdate: onRatingUpdate,
            updateOnDrag: updateOnDrag,
          );
  }
}

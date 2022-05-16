import 'dart:ffi';

import 'package:arenation_app/models/arenas/modelArena.dart';

class AVGScore {
  static double getAVGScore(List<Review> reviews) {
    List scores = [];
    for (var score in reviews) {
      scores.add(score.qualification);
    }
    double averageScore =
        scores.reduce((prevVal, currVal) => prevVal + currVal) / scores.length;
    return double.parse(averageScore.toStringAsFixed(1));
  }
}

import 'package:arenation_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static TextStyle h1(BuildContext context) {
    return Theme.of(context).textTheme.headline3!.copyWith(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CustomColors.secondaryDark);
  }

  static TextStyle h2(BuildContext context) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        fontFamily: 'Poppins',
        fontSize: 20,
        letterSpacing: .25,
        fontWeight: FontWeight.bold,
        color: CustomColors.secondaryDark);
  }

  static TextStyle p300(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline4!.copyWith(
          fontFamily: 'Noto Sans',
          fontSize: 16,
          letterSpacing: .5,
          fontWeight: FontWeight.normal,
          color: color,
        );
  }

  static TextStyle p200(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        fontFamily: 'Noto Sans',
        fontSize: 14,
        letterSpacing: .25,
        fontWeight: FontWeight.normal,
        color: color);
  }

  static TextStyle p100(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        fontFamily: 'Noto Sans',
        fontSize: 12,
        letterSpacing: .4,
        fontWeight: FontWeight.normal,
        color: color);
  }

  static TextStyle caption(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        fontFamily: 'Noto Sans',
        fontSize: 12,
        letterSpacing: .4,
        fontWeight: FontWeight.bold,
        color: color);
  }

  static TextStyle buttonText(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        fontFamily: 'Poppins',
        fontSize: 14,
        letterSpacing: 1.25,
        fontWeight: FontWeight.bold,
        color: color);
  }
}

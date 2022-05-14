import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/text_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFieldDecoration {
  static InputDecoration textFieldDecoration(
      BuildContext context, String hintText, String label) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: CustomTextTheme.p300(context, CustomColors.secondaryDark),
      label: Text(
        label,
        textAlign: TextAlign.left,
        style: CustomTextTheme.caption(context, CustomColors.secondaryDark),
      ),
      border: InputBorder.none,
      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      filled: true,
      fillColor: Colors.transparent,
    );
  }
}

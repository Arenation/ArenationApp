import 'package:arenation_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomButtonStyle {
  static ButtonStyle solidButton(BuildContext context,
      {bool fullWidth = true}) {
    return ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color?>(CustomColors.primary500),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(24, 24, 24, 24),
        ),
        minimumSize: fullWidth
            ? MaterialStateProperty.all<Size>(
                const Size.fromHeight(50),
              )
            : null,
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))));
  }

  static ButtonStyle outlinedButton(BuildContext context,
      {bool fullWidth = true}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.fromLTRB(24, 24, 24, 24),
      ),
      minimumSize: fullWidth
          ? MaterialStateProperty.all<Size>(
              const Size.fromHeight(50),
            )
          : null,
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          side: BorderSide(
              color: CustomColors.primary500,
              style: BorderStyle.solid,
              width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

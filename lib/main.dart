import 'package:arenation_app/utils/button_style.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/textfield_style.dart';
import 'package:flutter/material.dart';
import "package:arenation_app/utils/text_theme.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: CustomColors.secondaryWhite),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Arenation"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Header 1",
                textAlign: TextAlign.left,
                style: CustomTextTheme.h1(context),
              ),
              Text(
                "Header 2",
                textAlign: TextAlign.left,
                style: CustomTextTheme.h2(context),
              ),
              Text(
                "Lorem ipsum ja yuigd 76ra iuh apka nds",
                textAlign: TextAlign.left,
                style:
                    CustomTextTheme.p300(context, CustomColors.secondaryDark),
              ),
              Text(
                "Lorem ipsum ja yuigd 76ra iuh apka nds",
                textAlign: TextAlign.left,
                style:
                    CustomTextTheme.p200(context, CustomColors.secondaryDark),
              ),
              Text(
                "Lorem ipsum ja yuigd 76ra iuh apka nds",
                textAlign: TextAlign.left,
                style:
                    CustomTextTheme.p100(context, CustomColors.secondaryDark),
              ),
              Text(
                "Caption",
                textAlign: TextAlign.left,
                style: CustomTextTheme.caption(
                    context, CustomColors.secondaryDark),
              ),
              Text(
                "Button",
                textAlign: TextAlign.left,
                style: CustomTextTheme.buttonText(
                    context, CustomColors.secondaryDark),
              ),
              TextButton(
                onPressed: null,
                style: CustomButtonStyle.solidButton(context, fullWidth: true),
                child: Text(
                  "Button",
                  textAlign: TextAlign.left,
                  style: CustomTextTheme.buttonText(
                      context, CustomColors.secondaryWhite),
                ),
              ),
              TextButton(
                onPressed: null,
                style:
                    CustomButtonStyle.outlinedButton(context, fullWidth: true),
                child: Text(
                  "Button",
                  textAlign: TextAlign.left,
                  style: CustomTextTheme.buttonText(
                      context, CustomColors.primary500),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: CustomColors.secondaryLight,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                child: TextFormField(
                    decoration: CustomTextFieldDecoration.textFieldDecoration(
                        context, "Correo electrónico", "Correo electrónico")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

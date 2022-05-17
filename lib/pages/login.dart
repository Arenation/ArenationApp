import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/textfield_style.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../utils/button_style.dart';
import '../utils/text_theme.dart';
import '../utils/check_email.dart';
import 'package:provider/provider.dart';
import '../services/http/users/getUser.dart';
import '../services/http/users/httpstate.dart';
import '../models/response.dart';
import '../models/users/modelUser.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CheckEmail checkEmail = CheckEmail();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColors.secondaryWhite,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          backgroundColor: CustomColors.secondaryWhite,
          // appBar: AppBar(
          //   // This works only for android users
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //     statusBarColor: Colors.w,
          //     statusBarIconBrightness: Brightness.light,
          //     statusBarBrightness: Brightness.light,
          //   ),
          // ),
          body: Consumer<GetUser>(builder: (context, serviceUser, child) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: SvgPicture.asset(
                          "assets/svg/logo_vertical.svg",
                          height: 80,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context,
                                  "Correo electrónico",
                                  "Correo electrónico"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            } else if (checkEmail.getCheckEmail(value) ==
                                false) {
                              return '*Debe ingresar un correo electrónico válido';
                            }
                            email = value;
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 32),
                        child: TextFormField(
                            obscureText: true,
                            decoration:
                                CustomTextFieldDecoration.textFieldDecoration(
                                    context, "Contraseña", "Contraseña"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return '*Debe llenar este campo';
                              }
                              password = value;
                              return null;
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              serviceUser.setState(StateHttpUser.loading);
                              Future<Response> response =
                                  serviceUser.login(email, password);
                              response.then((Response response) {
                                if (serviceUser.state ==
                                    StateHttpUser.success) {
                                  var dar = response.getData as DataUsers;
                                  if (dar.status == "success") {
                                    Navigator.pushNamed(context, "/home");
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Usuario o contraseña incorrectos'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Aceptar'),
                                            onPressed: () {
                                              serviceUser
                                                  .setState(StateHttpUser.init);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            }
                          },
                          style: CustomButtonStyle.solidButton(context,
                              fullWidth: true),
                          child: Text( StateHttpUser.loading == serviceUser.state
                              ? "Cargando..."
                              : "Iniciar sesión",
                            style: CustomTextTheme.buttonText(
                                context, CustomColors.secondaryWhite),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: CustomButtonStyle.outlinedButton(context,
                            fullWidth: true),
                        child: Text(
                          "Registrate",
                          textAlign: TextAlign.left,
                          style: CustomTextTheme.buttonText(
                              context, CustomColors.primary500),
                        ),
                      ),
                    ],
                  ),
                ));
          })),
    );
  }
}

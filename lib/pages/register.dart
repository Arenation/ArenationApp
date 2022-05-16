import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/textfield_style.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../utils/button_style.dart';
import '../utils/text_theme.dart';
import '../utils/check_email.dart';
import 'package:provider/provider.dart';
import '../services/http/users/getUser.dart';
import '../services/http/users/httpstate.dart';
import '../../models/users/modelUser.dart';

class Register extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CheckEmail checkEmail = CheckEmail();
  DateTime date = DateTime.now();
  Map<String, String> data = {};
  String state = "";
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GetUser>(builder: (context, serviceUser, child) {
      return Padding(
          padding: const EdgeInsets.all(30.0),
          child: FutureBuilder<DataRegister>(
              future: serviceUser.state == StateHttpUser.loading
                  ? serviceUser.register(data)
                  : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.status);
                  message = snapshot.data!.message;
                  state = snapshot.data!.status;
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/logo_vertical.svg',
                        height: 80,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context, "Nombres", "Nombres"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            }
                            data["names"] = value;
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context, "Apellidos", "Apellidos"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            }
                            data["lastnames"] = value;
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context,
                                  "Fecha de nacimiento",
                                  "Fecha de nacimiento"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            }
                            data["date"] =
                                "${date.year}-${date.month}-${date.day}";
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
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
                            data["email"] = value;
                            return null;
                          },
                        ),
                      ),
                      if(state != "success")
                        Text(
                          message,
                        ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context, "Contraseña", "Contraseña"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            }
                            data["password"] = value;
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                            decoration:
                                CustomTextFieldDecoration.textFieldDecoration(
                                    context,
                                    "Confirmar contraseña",
                                    "Confirmar contraseña"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return '*Debe llenar este campo';
                              } else if (value != data["password"]) {
                                return '*Las contraseñas no coinciden';
                              }
                              return null;
                            }),
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            serviceUser.setState(StateHttpUser.loading);
                          }
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
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          "Regresar",
                          textAlign: TextAlign.left,
                          style: CustomTextTheme.buttonText(
                              context, CustomColors.primary500),
                        ),
                      ),
                    ],
                  ),
                );
              }));
    }));
  }
}

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

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CheckEmail checkEmail = CheckEmail();

  DateTime date = DateTime(2001, 1, 28);

  Map<String, String> data = {};

  String state = "";

  String message = "";

  @override
  Widget build(BuildContext mainContext) {
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
                  message = snapshot.data!.message;
                  state = snapshot.data!.status;
                  if (state == "success") {
                    return registerOK(mainContext);
                  }
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
                          controller: TextEditingController(
                              text: date.toString().substring(0, 10)),
                          readOnly: true,
                          onTap: () {
                            showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.dark(),
                                        child: child!,
                                      );
                                    },
                                    keyboardType: TextInputType.datetime,
                                    helpText:
                                        "Seleccione la fecha de nacimiento",
                                    cancelText: "Cancelar",
                                    confirmText: "Aceptar",
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2006, 12, 31))
                                .then((DateTime? value) {
                              if (value != null) {
                                setState(() {
                                  date = value;
                                });
                              }
                            });
                          },
                          decoration:
                              CustomTextFieldDecoration.textFieldDecoration(
                                  context, "AAAA-MM-DD", "Fecha de nacimiento"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '*Debe llenar este campo';
                            }
                            data["date"] = date.toString().substring(10);
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
                      Container(
                        decoration: BoxDecoration(
                            color: CustomColors.secondaryLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          obscureText: true,
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
                            obscureText: true,
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
                      if (state != "success")
                        Text(
                          message,
                          style: const TextStyle(color: Colors.red),
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
                          StateHttpUser.loading == serviceUser.state
                              ? "Registrando..."
                              : "Registrar",
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

  Widget registerOK(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/logo_vertical.svg',
              height: 80,
            ),
            Text(
              "Registro exitoso",
              style: CustomTextTheme.h1(context),
            ),
            Text(
              "Ahora puedes iniciar sesión",
              style: CustomTextTheme.h1(context),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              style: CustomButtonStyle.outlinedButton(context, fullWidth: true),
              child: Text(
                "Iniciar sesión",
                textAlign: TextAlign.left,
                style: CustomTextTheme.buttonText(
                    context, CustomColors.primary500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Correo electrónico"),
      content: Text("El correo electrónico ya está registrado"),
      actions: [
        TextButton(
          child: const Text("Aceptar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

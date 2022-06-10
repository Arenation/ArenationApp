import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../../services/http/arenas/getArenas.dart';
import '../../utils/button_style.dart';
import '../../utils/textfield_style.dart';
import 'package:arenation_app/utils/text_theme.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const InformationStatefulWidget();
  }
}

class InformationStatefulWidget extends StatefulWidget {
  const InformationStatefulWidget({Key? key}) : super(key: key);
  @override
  _InformationStatefulWidgetState createState() =>
      _InformationStatefulWidgetState();
}

class _InformationStatefulWidgetState extends State<InformationStatefulWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        titleSpacing: 0,
        title: Text("Información personal",
            style: TextStyle(color: CustomColors.secondaryDark)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: CustomColors.secondaryDark,
          ),
        ),
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: _bodyPage(context, getArenas),
            ),
          );
        },
      ),
    );
  }

  Widget _bodyPage(BuildContext context, GetArenas arenas) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime date = DateTime(2001, 01, 28);
    Map<String, String> data = {};
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Nombres",
            style: TextStyle(
                color: CustomColors.secondaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextFormField(
            initialValue: "Faber Alberto",
            decoration: CustomTextFieldDecoration.textFieldDecoration(
                context, "Nombres", "Nombres"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '*Debe llenar este campo';
              }
              data["name"] = value;
              return null;
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            initialValue: "Hoyos Ordosgoitia",
            decoration: CustomTextFieldDecoration.textFieldDecoration(
                context, "Apellidos", "Apellidos"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '*Debe llenar este campo';
              }
              data["lastname"] = value;
              return null;
            },
          ),
        ),
        Text("Fecha de nacimiento",
            style: TextStyle(
                color: CustomColors.secondaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextFormField(
            controller:
                TextEditingController(text: date.toString().substring(0, 10)),
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
                      helpText: "Seleccione la fecha de nacimiento",
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
            decoration: CustomTextFieldDecoration.textFieldDecoration(
                context, "Fecha de nacimiento", "Fecha de nacimiento"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '*Debe llenar este campo';
              }
              data["lastname"] = value;
              return null;
            },
          ),
        ),
        Text("Número de Teléfono",
            style: TextStyle(
                color: CustomColors.secondaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextFormField(
            initialValue: "+57 301-876-8768",
            decoration: CustomTextFieldDecoration.textFieldDecoration(
                context, "Número de Teléfono", "Número de Teléfono"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '*Debe llenar este campo';
              }
              data["lastname"] = value;
              return null;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: CustomButtonStyle.solidButton(context,
                    fullWidth: false, pd: 14),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                child: Text(
                  "Guardar Cambios",
                  style: CustomTextTheme.p300(
                      context, CustomColors.secondaryWhite),
                )),
            TextButton(
                style: CustomButtonStyle.outlinedButton(context,
                    fullWidth: false, pd: 14),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                child: Text(
                  "Cancelar",
                  style: CustomTextTheme.p300(context, CustomColors.primary500),
                )),
          ],
        ),
      ]);
    });
  }
}

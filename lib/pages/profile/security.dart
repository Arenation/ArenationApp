import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../../services/http/arenas/getArenas.dart';
import '../../utils/button_style.dart';
import '../../utils/textfield_style.dart';
import 'package:arenation_app/utils/text_theme.dart';

class Security extends StatelessWidget {
  const Security({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SecurityStatefulWidget();
  }
}

class SecurityStatefulWidget extends StatefulWidget {
  const SecurityStatefulWidget({Key? key}) : super(key: key);
  @override
  _SecurityStatefulWidgetState createState() => _SecurityStatefulWidgetState();
}

class _SecurityStatefulWidgetState extends State<SecurityStatefulWidget> {
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
        title: Text("Seguridad",
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

  Widget _bodyPage(BuildContext context, GetArenas getArenas) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contraseña Actual",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.secondaryDark,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: CustomColors.secondaryLight,
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextFormField(
              decoration: CustomTextFieldDecoration.textFieldDecoration(
                  context, "Ingrese contraseña actual", "Contraseña actual"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '*Debe llenar este campo';
                }
                return null;
              },
            ),
          ),
          Text(
            "Nueva Contraseña",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.secondaryDark,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: CustomColors.secondaryLight,
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextFormField(
              decoration: CustomTextFieldDecoration.textFieldDecoration(
                  context, "Ingrese nueva contraseña", "Nueva contraseña"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '*Debe llenar este campo';
                }
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
              decoration: CustomTextFieldDecoration.textFieldDecoration(context,
                  "Confirme nueva contraseña", "Confirme nueva contraseña"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '*Debe llenar este campo';
                }
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
                    style:
                        CustomTextTheme.p300(context, CustomColors.primary500),
                  )),
            ],
          ),
        ]);
  }
}

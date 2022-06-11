import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../services/http/arenas/getArenas.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/button_style.dart';
import 'package:arenation_app/utils/text_theme.dart';
import '../services/httpstate.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.secondaryWhite,
        elevation: 0,
        // title: Text("Arenation", style: CustomTextTheme.h2(context),),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SvgPicture.asset("assets/svg/logo.svg"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.secondaryLight,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: CustomColors.placeholderColor,
                  )),
            ),
          )
        ],
      ),
      body: Consumer<GetArenas>(
        builder: (_context, getArenas, child) {
          return _bodyPage(context, getArenas);
        },
      ),
    );
  }

  Widget _bodyPage(BuildContext context, GetArenas arenas) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            "Configuración de cuenta",
            style: TextStyle(
                color: CustomColors.secondaryDark,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile/information');
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CustomColors.secondaryLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Información personal",
                    style: TextStyle(
                        color: CustomColors.secondaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Modifica y actualiza tus datos personales, esto nos ayudará a contactarnos contigo cuando sea necesario.",
                    style: TextStyle(
                        color: CustomColors.secondaryDark, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile/security');
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CustomColors.secondaryLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seguridad",
                    style: TextStyle(
                        color: CustomColors.secondaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Cambiar la contraseña periodicamente te ayudará a proteger tu cuenta.",
                    style: TextStyle(
                        color: CustomColors.secondaryDark, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile/payment');
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CustomColors.secondaryLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Métodos de pago",
                    style: TextStyle(
                        color: CustomColors.secondaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Añade tus métodos de pago para que puedas pagar desde la app.",
                    style: TextStyle(
                        color: CustomColors.secondaryDark, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
          ),
          TextButton(
            style: CustomButtonStyle.outlinedButton(context,
                fullWidth: false, pd: 14),
            onPressed: (){
              /* arenas.logout(); */
              Provider.of<GetArenas>(context, listen: false).setStateOne(StateHttp.loading);
              Navigator.pushNamed(context, '/');
            },
            child: Text(
              "Cerrar sesión",
              style: CustomTextTheme.p300(context, CustomColors.primary500,
                  weight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

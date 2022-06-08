import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/httpstate.dart';
import '../utils/textfield_style.dart';

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
        titleSpacing: 0,
        title:
            Text("Cuenta", style: TextStyle(color: CustomColors.secondaryDark)),
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
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile/edit');
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
              Navigator.pushNamed(context, '/profile/edit');
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
              Navigator.pushNamed(context, '/profile/edit');
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
          
        ],
      ),
    );
  }
}

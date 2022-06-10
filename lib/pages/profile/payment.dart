import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import '../../services/http/arenas/getArenas.dart';
import '../../utils/button_style.dart';
import '../../utils/textfield_style.dart';
import 'package:arenation_app/utils/text_theme.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const PaymentStatefulWidget();
  }
}

class PaymentStatefulWidget extends StatefulWidget {
  const PaymentStatefulWidget({Key? key}) : super(key: key);
  @override
  _PaymentStatefulWidgetState createState() => _PaymentStatefulWidgetState();
}

class _PaymentStatefulWidgetState extends State<PaymentStatefulWidget> {
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
        title: Text("Métodos de pago",
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
      children: [
        Text(
          "Agregar Métodos de pago",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CustomColors.secondaryDark,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
        ),
        Text(
          "Agregando métodos de pago, podrás pagar las reservas que hagas desde nuestra plataforma, de forma rápida y segura.",
          style: TextStyle(color: CustomColors.secondaryDark, fontSize: 16),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.paid,
                  color: CustomColors.secondaryDark,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PSE de Arenation",
                    style: TextStyle(
                        color: CustomColors.secondaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "arenationpse@arenation.com",
                    style: TextStyle(
                        color: CustomColors.secondaryDark, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: CustomColors.secondaryLight,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.credit_card,
                  color: CustomColors.secondaryDark,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tarjeta de crédito Arenation",
                    style: TextStyle(
                        color: CustomColors.secondaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "**** **** **** 1234",
                    style: TextStyle(
                        color: CustomColors.secondaryDark, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        TextButton(
            style: CustomButtonStyle.solidButton(context, pd: 14),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Agregar Método de Pago",
              style: CustomTextTheme.p300(context, CustomColors.secondaryWhite,
                  weight: FontWeight.bold),
            )),
      ],
    );
  }
}

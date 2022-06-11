import 'package:arenation_app/services/http/users/getUser.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/text_theme.dart';
import 'package:arenation_app/widgets/skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/httpstate.dart';
import '../models/response.dart';
import '../models/arenas/modelArena.dart';
import 'package:arenation_app/utils/functions/get_avg_score.dart';
import "package:intl/intl.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/button_style.dart';
import '../utils/textfield_style.dart';
import 'package:arenation_app/utils/components/btnNavigation.dart';

class Events extends StatelessWidget {
  Events({Key? key}) : super(key: key);
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return EventsStatefuWidget();
  }
}

class EventsStatefuWidget extends StatefulWidget {
  EventsStatefuWidget({Key? key}) : super(key: key);
  @override
  _EventsStatefuWidgetState createState() => _EventsStatefuWidgetState();
}

class _EventsStatefuWidgetState extends State<EventsStatefuWidget> {
  int counter = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          counter = counter + 1;
          if (counter == 2) {
            Fluttertoast.showToast(
                msg: "Presiona nuevamente para salir de la aplicación",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
            Future.delayed(const Duration(seconds: 3), () {
              counter = 0;
            });
          } else if (counter == 3) {
            counter = 0;
            Provider.of<GetArenas>(context, listen: false)
                .setStateOne(StateHttp.init);
            Navigator.pushNamed(context, "/");
          }
          return false;
        },
        child: Scaffold(
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
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _body(context),
            )));
  }

  Widget _body(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(
        "assets/svg/Empty.svg",
        /* width: MediaQuery.of(context).size.width * 0.8, */
      ),
      Text("¡No hay nada por aquí!",
          style: CustomTextTheme.h1(context).copyWith(fontWeight: FontWeight.w300)),
      const SizedBox(height: 20),
      Text("No te preocupes, te avisaremos cuando tengamos algo nuevo para ti.",
          textAlign: TextAlign.center,
          style: CustomTextTheme.p300(context, CustomColors.secondaryDark).copyWith(fontWeight: FontWeight.w300)),
    ]);
  }
}

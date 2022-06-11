import 'package:flutter/material.dart';
import '../utils/components/btnNavigation.dart';
import '../pages/routesWidgets.dart';
import 'package:provider/provider.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/httpstate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arenation_app/utils/components/btnNavigation.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int counter = 0;
  int index = 1;
  BottomNavigator? MyBarBottom;
  @override
  void initState() {
    MyBarBottom = BottomNavigator(CurrentIndex: (i){
      setState(() {
        index = i;
      });
    });
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
        bottomNavigationBar: MyBarBottom,
        body: RoutesWigets(index: index),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';
import '../../services/http/arenas/getArenas.dart';
import '../../services/httpstate.dart';

class BottomNavigator extends StatefulWidget {
  final Function CurrentIndex;
  BottomNavigator({Key? key, required this.CurrentIndex}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: CustomColors.secondaryWhite,
      currentIndex: _currentIndex,
      selectedItemColor: CustomColors.primary500,
      selectedFontSize: 16,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Mi Cuenta',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          widget.CurrentIndex(index);
        });
        if (index == 1){
          Provider.of<GetArenas>(context, listen: false).setStateOne(StateHttp.loading);
        }
      },
    );
  }
}

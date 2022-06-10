import 'package:flutter/material.dart';
import 'package:arenation_app/utils/custom_colors.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

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
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

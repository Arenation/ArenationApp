import 'package:flutter/material.dart';

class ArenaSelected extends ChangeNotifier{
  String? arena = "";

  String? get id => arena;

  void setId(String? arenaSelected){
    arena = arenaSelected;
    notifyListeners();
  }
  
}
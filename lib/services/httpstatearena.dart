import 'package:flutter/material.dart';

enum StateHttpArena { init, loading, error, success }

class HttpStateArena extends ChangeNotifier {
  StateHttpArena _state = StateHttpArena.init;

  StateHttpArena get state => _state;

  void setStateArena(StateHttpArena viewState) {
    _state = viewState;
    notifyListeners();
  }
}

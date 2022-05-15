import 'package:flutter/material.dart';

enum StateHttpUser { init, loading, error, success }

class HttpState extends ChangeNotifier {
  StateHttpUser _state = StateHttpUser.init;

  StateHttpUser get state => _state;

  void setState(StateHttpUser viewState) {
    _state = viewState;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

enum StateHttp { init, loading, error, success }

class HttpState extends ChangeNotifier {
  StateHttp _state = StateHttp.init;

  StateHttp get state => _state;

  void setState(StateHttp viewState) {
    _state = viewState;
    notifyListeners();
  }
}

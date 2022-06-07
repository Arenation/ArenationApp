import 'package:flutter/material.dart';

enum StateHttp { init, loading, error, success }

class HttpState extends ChangeNotifier {
  StateHttp _state = StateHttp.init;
  StateHttp _stateOne = StateHttp.init;

  StateHttp get state => _state;
  StateHttp get stateOne => _stateOne;

  void setState(StateHttp viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setStateOne(StateHttp viewState) {
    _stateOne = viewState;
    notifyListeners();
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/response.dart';
import './httpstate.dart';
import '../../servicesconfig.dart';
import './httbase.dart';
import '../../../models/users/modelUser.dart';

class GetUser extends HttpBase {
  GetUser() {
    setState(StateHttpUser.init);
  }

  User? user;

  @override
  Future<Response> login(String email, String password) async {
    http.Client _client = http.Client();
    try {
      http.Response _response = await _client.post(
        Uri.parse(ServicesConfig.baseUrl + "api/users/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final Response _decodeResponse = decodeResponse(_response);
      _client.close();

      return _decodeResponse;
    } on SocketException catch (e) {
      setState(StateHttpUser.error);
      return Response<String>("No hay conexión a internet");
    }
  }

  Duration onTimeLimit() {
    return ServicesConfig.timeOutLimit;
  }

  @override
  Response decodeResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        setState(StateHttpUser.success);
        return Response<DataUsers>(
            DataUsers.fromJson(json.decode(response.body)));
      case 404:
        setState(StateHttpUser.error);
        return Response<String>("404 Not Found");
      default:
        setState(StateHttpUser.error);
        return Response<String>("500 Internal Server Error");
    }
  }
}

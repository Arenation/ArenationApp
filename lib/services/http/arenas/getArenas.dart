import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/response.dart';
import '../../httpstate.dart';
import '../../servicesconfig.dart';
import 'httpbase.dart';
import '../../../models/arenas/modelArena.dart';

class GetArenas extends HttpBase {
  GetArenas() {
    setState(StateHttp.init);
  }

  @override
  Future<Response> getArenas() async {
    http.Client _client = http.Client();
    try {
      http.Response _response = await _client
          .get(
            Uri.parse(ServicesConfig.baseUrl + "api/arenas"),
          )
          .timeout(onTimeLimit());

      final Response _decodeResponse = decodeResponse(_response);

      _client.close();
      return _decodeResponse;
    } on SocketException catch (e) {
      setState(StateHttp.error);
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
        setState(StateHttp.success);
        return Response<DataResponseArenas>(
            DataResponseArenas.fromJson(json.decode(response.body)));
      case 404:
        setState(StateHttp.error);
        return Response<String>("404 Not Found");
      default:
        setState(StateHttp.error);
        return Response<String>("500 Internal Server Error");
    }
  }
}

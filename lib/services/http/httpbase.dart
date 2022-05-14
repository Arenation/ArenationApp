import 'package:http/http.dart' as http;
import '../../models/response.dart';
import '../httpstate.dart';

abstract class HttpBase extends HttpState {
  Future<Response> getArenas();

  /* Future<Response> getArenasById(String id);

  Future<Response> getUserById(String id);

  Future<Response> login(String email, String password); */

  Response decodeResponse(http.Response response) {
    switch (response.statusCode) {
      case 404:
        setState(StateHttp.error);
        return Response<String>("404 Not Found");

      default:
        setState(StateHttp.error);
        return Response<String>("500 Internal Server Error");
    }
  }
}

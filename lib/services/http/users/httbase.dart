import 'package:http/http.dart' as http;
import '../../../models/response.dart';
import './httpstate.dart';
import '../../../models/users/modelUser.dart';

abstract class HttpBase extends HttpState {
  Future<Response> login(String email, String password);

  Future<DataRegister> register(Map<String, String> data); 

  /*Future<Response> getUserById(String id);

  Future<Response> login(String email, String password); */

  Response decodeResponse(http.Response response) {
    switch (response.statusCode) {
      case 404:
        setState(StateHttpUser.error);
        return Response<String>("404 Not Found");

      default:
        setState(StateHttpUser.error);
        return Response<String>("500 Internal Server Error");
    }
  }
}

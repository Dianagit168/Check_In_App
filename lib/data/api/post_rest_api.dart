import 'package:check_in_app/index.dart';
import 'package:http/http.dart' as http;

class PostRestApi {

  static Map<String, String> conceteHeader({String? key, String? value}) { /* Concete More Content Of Header */
    return key != null 
    ? { /* if Parameter != Null = Concete Header With  */
      "Content-Type": "application/json; charset=utf-8", 
      'accept': 'application/json',
      key: value!
    }
    : { /* if Parameter Null = Don't integrate */
      "Content-Type": "application/json; charset=utf-8",
      'accept': 'application/json'
    };
  }

  Future<http.Response> loginApi({required String email, required String password}) async {
    
    return await http.post(
      Uri.parse("${dotenv.env["API_URL"]}${dotenv.env["API_LOGIN"]}"),
      headers: conceteHeader(),
      body: json.encode({
        "email": email,
        "password": password
      }),
    );
  }

  Future<http.Response> registerApi({required String name, required String email, required String password, required String confirmPassword}) async {

    return await http.post(
      Uri.parse("${dotenv.env["API_URL"]}${dotenv.env["API_REGISTER"]}"),
      headers: conceteHeader(),
      body: json.encode({
        "name": name,
        "email": email,
        "password": password,
        "passwordConfirm": confirmPassword,
      }),
    );
  }

  Future<http.Response> redeemTicketApi(String redeemJson) async {

    return SecureStorage.readSecure(DbKey.bearerToken).then((token) async {
      return await http.post(
        Uri.parse("${dotenv.env["API_URL"]}api/ticket/redeemed?token=$token"),
        headers: conceteHeader(),
        body: redeemJson
      );
    });

  }

}

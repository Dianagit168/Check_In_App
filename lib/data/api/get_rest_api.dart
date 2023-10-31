import 'package:check_in_app/index.dart';
import 'package:http/http.dart' as http;

class GetRestApi {

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

  Future<http.Response> getTicketApi({required String id}) async {

      return SecureStorage.readSecure(DbKey.bearerToken).then((token) async {

        return await http.get(
          Uri.parse("${dotenv.env["API_URL"]}api/ticket/order/$id?token=$token"),
          headers: conceteHeader()
        );
        
      });
  
  }
  
}
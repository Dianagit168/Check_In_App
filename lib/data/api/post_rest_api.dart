import 'package:http/http.dart' as http;

class RestApi {

  Future<http.Response> loginApi(String username, String password) async {

    return await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      body: {
        'username': username,
        'password': password,
      },
    );
  }
  
}

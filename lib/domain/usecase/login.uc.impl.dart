import 'package:check_in_app/data/api/rest_api.dart';
import 'package:check_in_app/presentation/screen/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginUcImpl {
  BuildContext? _context;

  final RestApi _restApi = RestApi();

  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();

  Response? response;

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  void login() async {
    await _restApi.loginApi(c1.text, c2.text).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.of(_context!).pop();
        Navigator.push(
          _context!,
          MaterialPageRoute(
            builder: (context) => const MainTap(),
          ),
        );
      } else {
        Navigator.pop(_context!);
      }
    });
    print('access login');
  }
}

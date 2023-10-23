import 'package:check_in_app/index.dart';


class LoginUcImpl {
  BuildContext? _context;

  final RestApi _postApi = RestApi();

  final TextEditingController emailController = TextEditingController(text: "kminchelle");
  final TextEditingController passwordController = TextEditingController(text: "0lelplR");

  Response? response;

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  void loginRequest() async {
    await _postApi.loginApi(emailController.text, passwordController.text).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.of(_context!).pop();
        Navigator.push(
          _context!,
          MaterialPageRoute(
            builder: (context) => MainTap(),
          ),
        );
      } else {
        Navigator.pop(_context!);
      }
    });
    print('access login');
  }
}

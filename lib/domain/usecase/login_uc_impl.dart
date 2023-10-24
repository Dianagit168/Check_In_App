import 'package:check_in_app/index.dart';
import 'package:check_in_app/presentation/widget/alert_dialog_cus.dart';


class LoginUcImpl {
  BuildContext? _context;

  final RestApi _postApi = RestApi();

  final TextEditingController emailController = TextEditingController(text: "kminchelle");
  final TextEditingController passwordController = TextEditingController(text: "0lelplR");

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  void loginRequest() async {

    ModernDialog().dialogLoading(_context!);
    
    try {

      if (emailController.value.text.isNotEmpty && passwordController.value.text.isNotEmpty) {
      await _postApi.loginApi(emailController.text, passwordController.text).then((response) {
        if (response.statusCode == 200) {
          Navigator.of(_context!).pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          ModernDialog().errorMsg(_context!, "Email or Password is incorrect");
        }
      });
    } else {
      ModernDialog().errorMsg(_context!, "Please input Email and Password");
    }
      
    } catch (e) {
      Navigator.pop(_context!);
      ModernDialog().errorMsg(_context!, "Something went wrong. Please try again!");
    }
  }
}

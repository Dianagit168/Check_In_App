import 'package:check_in_app/index.dart';

class AuthModel {

  Map<String, dynamic>? decode;
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController(text: "developer@bookme.plus");
  final TextEditingController passwordController = TextEditingController(text: "9TZ1mJluJ+PbgA==");
  final TextEditingController confirmpasswordController = TextEditingController();

}
import 'package:check_in_app/index.dart';

class AuthUcImpl {
  BuildContext? _context;
  final PostRestApi _postApi = PostRestApi();
  final AuthModel authModel = AuthModel();

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  Future<void> checkExistAcc() async {
    
    await SecureStorage.readSecure(DbKey.bearerToken).then((token) async {
      
      Future.delayed(const Duration(seconds: 1), () {
        if(token == "") {
          _context!.goNamed(RouterName.loginScreen);
        }
        else {
          _context!.goNamed(RouterName.mainScreen);
        }
      });

    });

  }

  Future<void> loginRequest({required String email, required String password}) async {
    ModernDialog().dialogLoading(_context!);

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var response = await _postApi.loginApi(email: email, password: password);
        
        authModel.decode = json.decode(response.body);

        if (response.statusCode == 200) {
          await SecureStorage.writeSecure(DbKey.bearerToken, authModel.decode!['token']).then((value) {
            _context!.goNamed(RouterName.mainScreen);
          });
          
        } else {
          showErrorDialog("Something went wrong. Please try again!");
        }
      } else {
        showErrorDialog("Please input Email and Password");
      }
    } catch (e) {
      showErrorDialog("Something went wrong. Please try again!");
    }
  }

  Future<void> registerRequest({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    ModernDialog().dialogLoading(_context!);

    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
        if (password == confirmPassword) {
          var registerResponse = await _postApi.registerApi(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          );

          authModel.decode = json.decode(registerResponse.body);

          if (authModel.decode!["status"] == "success") {
            var loginResponse = await _postApi.loginApi(email: email, password: password);

            authModel.decode = json.decode(loginResponse.body);

            if (loginResponse.statusCode == 200) {
              await SecureStorage.writeSecure(DbKey.bearerToken, authModel.decode!['token']).then((value) {
                _context!.goNamed(RouterName.mainScreen);
              });
            } else {
              showErrorDialog("Something went wrong. Please try again!");
            }
          } else {
            showErrorDialog("Something went wrong. Please try again!");
          }
        } else {
          showErrorDialog("Password not match");
        }
      } else {
        showErrorDialog("Please input all field");
      }
    } catch (e) {
      showErrorDialog("Something went wrong. Please try again!");
    }
  }

  void showErrorDialog(String message) {
    ModernDialog().errorMsg(_context!, message).then((value) {
      Navigator.pop(_context!);
    });
  }
}

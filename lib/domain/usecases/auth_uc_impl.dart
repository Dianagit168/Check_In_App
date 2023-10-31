import 'package:check_in_app/index.dart';


class AuthUcImpl {
  BuildContext? _context;

  final PostRestApi _postApi = PostRestApi();

  final AuthModel authModel = AuthModel();

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  Future<void> loginRequest({required String email, required String password}) async {

    ModernDialog().dialogLoading(_context!);
    
    try {

      if (email.isNotEmpty && password.isNotEmpty) {
        await _postApi.loginApi(email: email, password: password).then((response) async {

          authModel.decode = json.decode(response.body);

          if (response.statusCode == 200) {

            await SecureStorage.writeSecure(DbKey.bearerToken, authModel.decode!['token']);

            Navigator.pushReplacement(_context!,
              MaterialPageRoute (builder: (context) {return const RunWithSaiScreen();})
            ); 

          } else {
            ModernDialog().errorMsg(_context!, "Something went wrong. Please try again!").then((value) {
              Navigator.pop(_context!);
            });
          }
        });
    } else {
      ModernDialog().errorMsg(_context!, "Please input Email and Password").then((value) {
        Navigator.pop(_context!);
      });
    }
      
    } catch (e) {
      Navigator.pop(_context!);
      ModernDialog().errorMsg(_context!, "Something went wrong. Please try again!");
    }
  }

  Future<void> registerRequest(
    {
      required String name,
      required String email, 
      required String password,
      required String confirmPassword
    }
  ) async {

    ModernDialog().dialogLoading(_context!);
    
    try {

      if (
        name.isNotEmpty &&
        email.isNotEmpty && 
        password.isNotEmpty &&
        confirmPassword.isNotEmpty
        ) {

          if(password == confirmPassword) {

            await _postApi.registerApi(
              name: name,
              email: email, 
              password: password,
              confirmPassword: confirmPassword
              ).then((registerResponse) async {
                authModel.decode = json.decode(registerResponse.body);

                if (authModel.decode!["status"] == "success") {
                  await _postApi.loginApi(email: email, password: password).then((loginResponse) async {

                    authModel.decode = json.decode(loginResponse.body);

                    if (loginResponse.statusCode == 200) {

                      await SecureStorage.writeSecure(DbKey.bearerToken, authModel.decode!['token']);

                      Navigator.pushReplacement(_context!,
                        MaterialPageRoute (builder: (context) {return const RunWithSaiScreen();})
                      ); 

                    } 
                  });

                } 

                else {
                  ModernDialog().errorMsg(_context!, "Something went wrong. Please try again!").then((value) {
                    Navigator.pop(_context!);
                  });
                }
              }
            );
          }
          else {
            ModernDialog().errorMsg(_context!, "Password not match").then((value) {
              Navigator.pop(_context!);
            });
          }
    
    } else {
      ModernDialog().errorMsg(_context!, "Please input all field").then((value) {
        Navigator.pop(_context!);
      });
    }
      
    } catch (e) {
      ModernDialog().errorMsg(_context!, "Something went wrong. Please try again!").then((value) {
        Navigator.pop(_context!);
      });
    }
  }

}

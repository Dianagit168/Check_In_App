import 'package:check_in_app/index.dart';
import 'package:check_in_app/presentation/screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  
  final AuthUcImpl authUcImpl = AuthUcImpl();

  @override
  Widget build(BuildContext context) {

    authUcImpl.setBuildContext = context;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                  image: AssetImage('assets/images/runwithsai.png')
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromRGBO(130, 102, 224, 0.7),
            ),

            //  Positioned(
            //   top: 75,
            //   right: 20,
            //   child: InkWell(
            //     onTap: () async {
            //       Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            //     },
            //     child: Container(
            //       padding: const EdgeInsets.all(12),
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(50)),
            //         color: Colors.white
            //       ),
            //       child: const Text(
            //         'Skip Login',
            //         style: TextStyle(
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromRGBO(130, 102, 224, 1),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.5 - 250, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Glassmorphism(
                    blur: 15,
                    opacity: 0.3,
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome RUN WITH SAI',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Crew Check-In',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textfieldWidget(
                                context,
                                const Icon(
                                  LucideIcons.user,
                                  color: Colors.white,
                                ),
                                'Email',
                                authUcImpl.authModel.emailController,
                              ),

                              const SizedBox(height: 10),

                              textfieldWidget(
                                context,
                                const Icon(
                                  LucideIcons.lock,
                                  color: Colors.white,
                                ),
                                'Password',
                                authUcImpl.authModel.passwordController,
                                isSecure: true
                              ),
                            ],
                          ),
                          
                          const SizedBox(
                            height: 25,
                          ),

                          ElevatedButtonCust(
                            tit: 'Login',
                            iconData: LucideIcons.logIn,
                            textColor: const Color.fromRGBO(130, 102, 224, 1),
                            iconColor: const Color.fromRGBO(130, 102, 224, 1),
                            borderColor: const Color.fromRGBO(130, 102, 224, 1),
                            btnHigh: 50,
                            onNavigator: () async {
                              await authUcImpl.loginRequest(
                                email: authUcImpl.authModel.emailController.value.text, 
                                password: authUcImpl.authModel.passwordController.value.text
                              );
                            },
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Positioned(
              bottom: 70,
              left: 15,
              right: 15,
              child: Glassmorphism(
                blur: 15,
                opacity: 0.3,
                radius: 50,
                child: ElevatedButtonCust(
                  tit: "Don't have account? CLICK HERE",
                  textColor: const Color.fromRGBO(130, 102, 224, 1),
                  iconColor: const Color.fromRGBO(130, 102, 224, 1),
                  borderColor: const Color.fromRGBO(130, 102, 224, 1),
                  btnHigh: 50,
                  onNavigator: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

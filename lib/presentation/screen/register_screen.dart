import 'dart:ui';
import 'package:check_in_app/index.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  
  final AuthUcImpl authUcImpl = AuthUcImpl();

  @override
  Widget build(BuildContext context) {

    authUcImpl.setBuildContext = context;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
              image: AssetImage('assets/images/runwithsai.png'),
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                    
                  Glassmorphism(
                    blur: 15,
                    opacity: 0.3,
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 27,
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
                                'Name',
                                authUcImpl.authModel.nameController,
                              ),
                  
                              const SizedBox(height: 10),
                  
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
                  
                              const SizedBox(height: 10),
                  
                              textfieldWidget(
                                context,
                                const Icon(
                                  LucideIcons.lock,
                                  color: Colors.white,
                                ),
                                'Confirm Password',
                                authUcImpl.authModel.confirmpasswordController,
                                isSecure: true
                              ),
                            ],
                          ),
                          
                          const SizedBox(
                            height: 15,
                          ),
                  
                          ElevatedButtonCust(
                            tit: 'Register',
                            iconData: LucideIcons.logIn,
                            textColor: const Color.fromRGBO(130, 102, 224, 1),
                            iconColor: const Color.fromRGBO(130, 102, 224, 1),
                            borderColor: const Color.fromRGBO(130, 102, 224, 1),
                            btnHigh: 50,
                            onNavigator: () async {
                              await authUcImpl.registerRequest(
                                name: authUcImpl.authModel.nameController.value.text,
                                email: authUcImpl.authModel.emailController.value.text,
                                password: authUcImpl.authModel.passwordController.value.text,
                                confirmPassword: authUcImpl.authModel.confirmpasswordController.value.text,
                              );
                            },
                          ),
                    
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  
                  Glassmorphism(
                    blur: 15,
                    opacity: 0.3,
                    radius: 50,
                    child: ElevatedButtonCust(
                      tit: "Already have account? CLICK HERE",
                      textColor: const Color.fromRGBO(130, 102, 224, 1),
                      iconColor: const Color.fromRGBO(130, 102, 224, 1),
                      borderColor: const Color.fromRGBO(130, 102, 224, 1),
                      btnHigh: 50,
                      onNavigator: () {
                        context.pop();
                      },
                    ),
                  ),

                  const SizedBox(height: 50),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}

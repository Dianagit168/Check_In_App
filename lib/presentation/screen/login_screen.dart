import 'package:check_in_app/index.dart';
import 'package:check_in_app/presentation/widget/glassmorphism_cus.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  
  final LoginUcImpl loginUcImpl = LoginUcImpl();

  @override
  Widget build(BuildContext context) {

    loginUcImpl.setBuildContext = context;

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

            Positioned(
              top: 75,
              right: 20,
              child: InkWell(
                onTap: () async {
                  Navigator.pushReplacementNamed(context, "/home");
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white
                  ),
                  child: const Text(
                    'Skip Login',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(130, 102, 224, 1),
                    ),
                  ),
                ),
              ),
            ),


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
                      padding: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
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
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _fieldLogin(
                                    context,
                                    const Icon(
                                      LucideIcons.user,
                                      color: Colors.white,
                                    ),
                                    'Email',
                                    loginUcImpl.emailController,
                                  ),
                                  _fieldLogin(
                                    context,
                                    const Icon(
                                      LucideIcons.lock,
                                      color: Colors.white,
                                    ),
                                    'Password',
                                    loginUcImpl.passwordController,
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(
                              height: 15,
                            ),

                            ElevatedButtonCust(
                              tit: 'Login',
                              textColor: const Color.fromRGBO(130, 102, 224, 1),
                              iconColor: const Color.fromRGBO(130, 102, 224, 1),
                              borderColor: const Color.fromRGBO(130, 102, 224, 1),
                              btnHigh: 50,
                              onNavigator: () {
                                loginUcImpl.loginRequest();
                              },
                            ),
                      
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLogin(
    BuildContext context,
    final Icon? icon,
    final String title,
    final TextEditingController? controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: icon!,
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}

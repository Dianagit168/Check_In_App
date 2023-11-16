import 'package:check_in_app/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final AuthUcImpl authUcImpl = AuthUcImpl();

  // Initially password is obscure
  bool obscureText = true;

  // Toggles the password show status
  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
  
  

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
              alignment: Alignment.center,
              image: AssetImage('assets/images/background.png'),
            ),
          ),
          child: Glassmorphism(
            blur: 3,
            opacity: 0.1,
            radius: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 75),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome AnyTicket',
                          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Crew Check-In',
                          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Glassmorphism(
                    blur: 15,
                    opacity: 0.15,
                    radius: 20,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Sign In", 
                                style: GoogleFonts.poppins(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 255, 255, 255)      
                                )
                              ),
                            ),

                            TextFormField(
                              style: GoogleFonts.poppins(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                prefixIcon: const Icon(LucideIcons.user, color: Color.fromARGB(255, 255, 255, 255))
                              ),
                              controller: authUcImpl.authModel.emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]+$').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            
                            const SizedBox(height: 16),

                            TextFormField(
                              style: GoogleFonts.poppins(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide:  const BorderSide(color: Colors.white),
                                ),
                                prefixIcon: const Icon(LucideIcons.lock, color: Color.fromARGB(255, 255, 255, 255)),
                                suffixIcon:  Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: GestureDetector(
                                    onTap: toggle,
                                    child: Icon(
                                      obscureText
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                      size: 24,
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                              obscureText: obscureText,
                              controller: authUcImpl.authModel.passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0),
                              child: ElevatedButtonCust(
                                tit: 'Login',
                                iconData: LucideIcons.logIn,
                                textColor: const Color.fromRGBO(553, 161, 218, 1),
                                iconColor: const Color.fromRGBO(553, 161, 218, 1),
                                borderColor: const Color.fromRGBO(553, 161, 218, 1),
                                btnHigh: 50,
                                onNavigator: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Form is valid, perform your action here
                                    await authUcImpl.loginRequest(
                                      email: authUcImpl.authModel.emailController.value.text,
                                      password: authUcImpl.authModel.passwordController.value.text,
                                    );
                                  }
                                  
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  

                  const Spacer(),

                  poweredByKoompiLogoWhite(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

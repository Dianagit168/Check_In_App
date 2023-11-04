import 'package:check_in_app/index.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Glassmorphism(
      blur: 3,
      opacity: 0.3,
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
            _buildHeader(),
            const SizedBox(height: 25),
            _buildForm(context),
            const Spacer(),
            _buildRegisterButton(context),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            'Welcome RUN WITH SAI',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Crew Check-In',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Glassmorphism(
      blur: 15,
      opacity: 0.3,
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTextField(context, LucideIcons.user, 'Email', authUcImpl.authModel.emailController),
            const SizedBox(height: 25),
            _buildTextField(context, LucideIcons.lock, 'Password', authUcImpl.authModel.passwordController, isSecure: true),
            const SizedBox(height: 25),
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
                  password: authUcImpl.authModel.passwordController.value.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, IconData icon, String labelText, TextEditingController controller, {bool isSecure = false}) {
    return textfieldWidget(
      context,
      Icon(icon, color: Colors.white),
      labelText,
      controller,
      isSecure: isSecure,
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButtonCust(
      tit: "Don't have an account? CLICK HERE",
      textColor: const Color.fromRGBO(130, 102, 224, 1),
      iconColor: const Color.fromRGBO(130, 102, 224, 1),
      borderColor: const Color.fromRGBO(130, 102, 224, 1),
      btnHigh: 50,
      onNavigator: () {
        context.pushNamed(RouterName.registerScreen);
      },
    );
  }
}

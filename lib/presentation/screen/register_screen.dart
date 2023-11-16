// import 'package:check_in_app/index.dart';

// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});

//   final AuthUcImpl authUcImpl = AuthUcImpl();

//   @override
//   Widget build(BuildContext context) {
//     authUcImpl.setBuildContext = context;

//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               alignment: Alignment.center,
//               image: AssetImage('assets/background.png'),
//             ),
//           ),
//           child: _buildContent(context),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(BuildContext context) {
//     return Glassmorphism(
//       blur: 3,
//       opacity: 0.3,
//       radius: 0,
//       child: Container(
//         padding: const EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.2),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50),
//             _buildHeader(),
//             const Spacer(),
//             _buildForm(context),
//             const SizedBox(height: 50),
//             _buildLoginButtonPage(context),
            
//             const Spacer(),

//             poweredByKoompiLogoWhite(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Padding(
//       padding: EdgeInsets.all(15.0),
//       child: Column(
//         children: [
//           Text(
//             'Sign Up',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           SizedBox(height: 10),
//           Text(
//             'Crew Check-In',
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm(BuildContext context) {
//     return Glassmorphism(
//       blur: 15,
//       opacity: 0.3,
//       radius: 20,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             _buildTextField(context, LucideIcons.user, 'Name', authUcImpl.authModel.nameController),
//             const SizedBox(height: 15),
//             _buildTextField(context, LucideIcons.user, 'Email', authUcImpl.authModel.emailController),
//             const SizedBox(height: 15),
//             _buildTextField(context, LucideIcons.lock, 'Password', authUcImpl.authModel.passwordController, isSecure: true),
//             const SizedBox(height: 15),
//             _buildTextField(context, LucideIcons.lock, 'Confirm Password', authUcImpl.authModel.confirmpasswordController, isSecure: true),
//             const SizedBox(height: 15),
//             ElevatedButtonCust(
//               tit: 'Register',
//               iconData: LucideIcons.logIn,
//               textColor: const Color.fromRGBO(553, 161, 218, 1),
//               iconColor: const Color.fromRGBO(553, 161, 218, 1),
//               borderColor: const Color.fromRGBO(553, 161, 218, 1),
//               btnHigh: 50,
//               onNavigator: () async {
//                 await authUcImpl.registerRequest(
//                   name: authUcImpl.authModel.nameController.value.text,
//                   email: authUcImpl.authModel.emailController.value.text,
//                   password: authUcImpl.authModel.passwordController.value.text,
//                   confirmPassword: authUcImpl.authModel.confirmpasswordController.value.text,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(BuildContext context, IconData icon, String labelText, TextEditingController controller, {bool isSecure = false}) {
//     return textfieldWidget(
//       context,
//       Icon(icon, color: Colors.white),
//       labelText,
//       controller,
//       isSecure: isSecure,
//     );
//   }

//   Widget _buildLoginButtonPage(BuildContext context) {
//     return ElevatedButtonCust(
//       tit: "Already have an account? CLICK HERE",
//       textColor: const Color.fromRGBO(553, 161, 218, 1),
//       iconColor: const Color.fromRGBO(553, 161, 218, 1),
//       borderColor: const Color.fromRGBO(553, 161, 218, 1),
//       btnHigh: 50,
//       onNavigator: () {
//         context.pop();
//       },
//     );
//   }
// }

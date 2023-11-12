// GoRouter configuration
import 'package:check_in_app/index.dart';

class RouterName {

  static String loginScreen = "/login-screen";
  static String registerScreen = "/register-screen";
  static String mainScreen = "/main-screen";
  static String scanCameraScreen = "/scan-camera";

}

final router = GoRouter(
  initialLocation: '/',
  routes: [ 
    GoRoute(
      name: "root", // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: RouterName.loginScreen,
      path: RouterName.loginScreen,
      builder: (context, state) => LoginScreen(),
    ),
    // GoRoute(
    //   name: RouterName.registerScreen,
    //   path: RouterName.registerScreen,
    //   builder: (context, state) => RegisterScreen(),
    // ),
    GoRoute(
      name: RouterName.mainScreen,
      path: RouterName.mainScreen,
      builder: (context, state) => RunWithSaiScreen(),
    ),
    GoRoute(
      name: RouterName.scanCameraScreen,
      path: RouterName.scanCameraScreen,
      builder: (context, state) => const ScanQrScreen(),
    ),
  ],
);
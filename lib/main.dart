import 'package:check_in_app/index.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AnyTicket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}


class SplashScreen extends StatelessWidget {

  final AuthUcImpl _authUcImpl = AuthUcImpl();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    _authUcImpl.setBuildContext = context;

    _authUcImpl.checkExistAcc();

    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Spacer(),

              ...[
                Lottie.asset(
                  "assets/animations/splash_screen.json",
                  repeat: true,
                  reverse: true,
                  height: 250,
                  width: 250
                ),
          
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Image.asset("assets/images/powered-by-koompi.png"),
              ),
              
        
            ],
          ),
        )
      )
    );
  }

}
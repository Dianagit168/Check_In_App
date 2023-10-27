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

Widget initialization() {
  // Load resource
  return FutureBuilder<String>(
    future: SecureStorage.readSecure(DbKey.bearerToken),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return const RunWithSaiScreen();
      } else {
        return LoginScreen();
      }
    },
  );
}

// Future<void> initialization() async {
//   // Load resource

//   print("run token");
//   // Future.delayed(const Duration(seconds: 3), () async {
//     await SecureStorage.readSecure(DbKey.bearerToken)!.then((token) async {

//       print(token);
//       if(token.isNotEmpty) {
//         const RunWithSaiScreen();
//       } 
//       else {
//         LoginScreen();
//       }
//     });
//   // });
  

// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initialization(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => LoginScreen(),
      //   '/home': (context) => const RunWithSaiScreen(),
      // },
    );
  }
}

import 'package:check_in_app/index.dart';

class RunWithSaiScreen extends StatelessWidget {
  const RunWithSaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "Crew Check In", isLeading: false),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                const Spacer(),
                
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        // const RedeemTicketScreen(),
                        const ScanQr(eventTitle: 'Run With Sai',),
                      )
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/runcover.png',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromRGBO(130, 102, 224, 1),
                          child: Row(
                            children: [
      
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    color: Color.fromRGBO(91, 81, 153, 1),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '12 Nov 2023',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Run With Sai',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
      
                                  SizedBox(height: 5),
      
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.mapPin,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Kep City',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                ElevatedButtonCust(
                  tit: 'Log Out',
                  btnColor: const Color.fromARGB(255, 235, 53, 53),
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  iconColor: const Color.fromARGB(255, 255, 255, 255),
                  borderColor: const Color.fromRGBO(130, 102, 224, 0.5),
                  btnHigh: 50,
                  onNavigator: () {
                    SecureStorage.clearAllSecure().then((value) {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute (builder: (context) {return LoginScreen();})
                      ); 
                    });
                    
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
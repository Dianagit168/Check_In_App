import 'package:check_in_app/index.dart';

class RunWithSaiScreen extends StatelessWidget {
  const RunWithSaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
            image: AssetImage('assets/images/runwithsai.png'),
          ),
        ),
        child: Glassmorphism(
          blur: 5,
          opacity: 0.3,
          radius: 0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                _buildHeaderText(),
                const Spacer(),
                _buildEventCard(context),
                const Spacer(),
                _buildLogoutButton(context),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Text(
      'AnyTicket: Crew Check In',
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          context.pushNamed(RouterName.scanCameraScreen);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/runcover.png',
              fit: BoxFit.cover,
            ),
            _buildEventDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: const Color.fromRGBO(130, 102, 224, 1),
      child: Row(
        children: [
          _buildDateContainer(context),
          _buildEventInfo(),
        ],
      ),
    );
  }

  Widget _buildDateContainer(BuildContext context) {
    return Padding(
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
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfo() {
    return const Expanded(
      child: Column(
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
              SizedBox(width: 5),
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
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButtonCust(
      tit: 'Log Out',
      btnColor: const Color.fromARGB(255, 255, 255, 255),
      textColor: const Color.fromARGB(255, 235, 53, 53),
      iconColor: const Color.fromARGB(255, 255, 255, 255),
      borderColor: const Color.fromRGBO(130, 102, 224, 0.5),
      btnHigh: 50,
      onNavigator: () {
        SecureStorage.clearAllSecure().then((value) {
          context.goNamed(RouterName.loginScreen);
        });
      },
    );
  }
}

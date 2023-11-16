import 'package:check_in_app/index.dart';

// NOTE: this is really important, it will make overscroll look the same on both platforms
class _ClampingScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const ClampingScrollPhysics();
}


class MainScreen extends StatelessWidget {

  final TicketUcImpl ticketUcImpl = TicketUcImpl();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ticketUcImpl.getCountTicketData();
    
    return Scaffold(
      body: LayoutBuilder(
        builder: ((_, constraints) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              await ticketUcImpl.getCountTicketData();
            },
            child: ScrollConfiguration(
              behavior: _ClampingScrollBehavior(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxHeight: constraints.maxHeight
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        filterQuality: FilterQuality.high,
                        image: AssetImage('assets/images/background.png'),
                      ),
                    ),
                    child: Glassmorphism(
                      blur: 5,
                      opacity: 0.3,
                      radius: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 75),
                            // _buildHeaderText(),

                            const Spacer(),
                            _buildEventCard(context),
                    
                            const Spacer(),
                            _buildLogoutButton(context),

                            const SizedBox(height: 15),
                            
                            // poweredByKoompiLogoWhite(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    ));
  }

  Widget _ticketCount() {
    return ValueListenableBuilder(
      valueListenable: ticketUcImpl.ticketCountModel,
      builder: (context, countTicketVal, wg) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Text(
                    "Total Ticket: ", 
                    style: GoogleFonts.poppins(
                      fontSize: 15, 
                      color: Colors.white,
                    ),
                  ),
                  
                  countTicketVal.total == null ? 
                  Text(
                    "0", 
                    style: GoogleFonts.poppins(
                      fontSize: 15, 
                      color: Colors.white,
                    ),
                  ) : 
                  //const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()) :
                  AnimatedFlipCounter(
                    value: countTicketVal.total![0].total!,
                    duration: const Duration(seconds: 1),
                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Text(
                    "Used Ticket: ", 
                    style: GoogleFonts.poppins(
                      fontSize: 15, 
                      color: Colors.white,
                    ),
                  ),
                  
                  countTicketVal.total == null  ?
                  Text(
                    "0", 
                    style: GoogleFonts.poppins(
                      fontSize: 15, 
                      color: Colors.white,
                    ),
                  ) : 
                  // ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()) :
                  AnimatedFlipCounter(
                    value: countTicketVal.used![0].used!,
                    duration: const Duration(seconds: 1),
                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),

          ],
        );
      }
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'AnyTicket crews check-in',
      style: GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return Card(
      elevation: 10,
      // color: const Color.fromRGBO(553, 161, 218, 1),
      color: const Color.fromARGB(255, 255, 255, 255),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          context.pushNamed(RouterName.scanCameraScreen);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/branding-white.png',
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
      color: const Color.fromRGBO(553, 161, 218, 1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildEventInfo(),
            _ticketCount(),
          ],
        ),
      ),
    );
  }

  // Widget _buildDateContainer(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(15),
  //     margin: const EdgeInsets.all(10.0),
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //       color: Color.fromRGBO(91, 81, 153, 1),
  //     ),
  //     child: Center(
  //       child: Text(
  //         '12 Nov\n2023',
  //         style: GoogleFonts.poppins(
  //           fontSize: 15,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEventInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'AnyTicket (Crew)',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // const SizedBox(height: 5),
        // Row(
        //   children: [
        //     const Icon(
        //       LucideIcons.mapPin,
        //       color: Colors.white,
        //     ),
        //     const SizedBox(width: 5),
        //     Text(
        //       'Kep City',
        //       style: GoogleFonts.poppins(
        //         fontSize: 15,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SafeArea(
      child: ElevatedButtonCust(
        tit: 'Log Out',
        btnColor: const Color.fromARGB(255, 255, 255, 255),
        textColor: const Color.fromARGB(255, 235, 53, 53),
        iconColor: const Color.fromARGB(255, 255, 255, 255),
        borderColor: const Color.fromRGBO(553, 161, 218, 1),
        btnHigh: 50,
        onNavigator: () {
          SecureStorage.clearAllSecure().then((value) {
            context.goNamed(RouterName.loginScreen);
          });
        },
      ),
    );
  }
}

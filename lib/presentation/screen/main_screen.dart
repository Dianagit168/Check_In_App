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
            color: const Color.fromRGBO(553, 161, 218, 1),
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
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    QuickAlert.show(
                                      context: context, 
                                      type: QuickAlertType.warning,
                                      barrierColor: const Color.fromRGBO(553, 161, 218, 0.2),
                                      title: "Warning",
                                      text: "Are you sure want to log out?",
                                      showCancelBtn: true,
                                      confirmBtnText: "Yes",
                                      cancelBtnText: "No",
                                      onConfirmBtnTap: () {
                                        SecureStorage.clearAllSecure().then((value) {
                                          context.goNamed(RouterName.loginScreen);
                                        });
                                      }
                                    );
                                    
                                  }, 
                                  icon: const Icon(LucideIcons.logOut, color: Colors.red, size: 27,)
                                ),
                              ),
                            ),

                            const Spacer(),

                            _buildEventCard(context),
                    
                            const Spacer(),

                            const SizedBox(height: 125),
                            
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
    ),
    floatingActionButton: FloatingActionButton.large(
      onPressed: () {
        context.pushNamed(RouterName.scanCameraScreen);
      },
      backgroundColor: const Color.fromRGBO(553, 161, 218, 1),
      tooltip: 'Scan QR',
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      splashColor: Colors.grey,
      child: const Icon(LucideIcons.camera, color: Colors.white, size: 50,),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
                      fontSize: 16, 
                      color: Colors.white,
                    ),
                  ),
                  
                  countTicketVal.total == null ? 
                  Text(
                    "0", 
                    style: GoogleFonts.poppins(
                      fontSize: 16, 
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
                      fontSize: 16, 
                      color: Colors.white,
                    ),
                  ),
                  
                  countTicketVal.total == null  ?
                  Text(
                    "0", 
                    style: GoogleFonts.poppins(
                      fontSize: 16, 
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

  Widget _buildEventInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'AnyTicket Crews',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

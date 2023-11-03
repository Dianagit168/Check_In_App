import 'package:check_in_app/index.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  ScanQrScreenState createState() => ScanQrScreenState();
}

class ScanQrScreenState extends State<ScanQrScreen> {
  final TicketUcImpl _ticketUcImpl = TicketUcImpl();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _qrViewController;

  bool _flashOn = false;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _qrViewController.dispose();
    super.dispose();
  }

  void _onQrViewCreated(QRViewController controller) {
    _qrViewController = controller;

    _qrViewController.scannedDataStream.listen((event) async {
      if (isScanning) {
        setState(() {
          isScanning = false;
        });

        List<String> parts = event.code!.split('/');
        String id = parts.last.split('-').first;

        print(event.code);

        // ModernDialog().dialogLoading(context);

        _ticketUcImpl.getTicketData(id).then((value) {
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RedeemTicketScreen(
                id: id,
                ticketUcImpl: _ticketUcImpl,
                ticketModel: _ticketUcImpl.ticketModel.value,
              ),
            ),
          ).then((_) {
            _qrViewController.resumeCamera().then((value) {
              setState(() {
                isScanning = true;
              });
            });
          });
        });

        _qrViewController.pauseCamera();

      }
    });
  }

  @override
  Widget build(BuildContext context) {

    _ticketUcImpl.setBuildContext = context;
    
    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "QR Scanner"),
      body: Stack(
        children: [
          QRView(
            cameraFacing: CameraFacing.back,
            key: qrKey,
            onQRViewCreated: _onQrViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 25,
              borderLength: 36,
              cutOutSize: MediaQuery.of(context).size.width / 1.25,
              cutOutBottomOffset: MediaQuery.of(context).size.height / 20,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 4.5,
            left: MediaQuery.of(context).size.width / 2.25,
            child: IconButton(
              onPressed: () {
                debugPrint("Controller is dead?: $_qrViewController");
                _qrViewController.toggleFlash();
                setState(() {
                  _flashOn = !_flashOn;
                });
              },
              color: Colors.white,
              iconSize: 36,
              icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
              alignment: Alignment.center,
            ),
          ),

          isScanning == false ? Positioned(
            top: 25,
            right: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _qrViewController.resumeCamera().then((value) {
                    setState(() {
                      isScanning = true;
                    });
                  });
                });
              },
              color: Colors.white,
              iconSize: 36,
              icon: const Icon(LucideIcons.refreshCcw),
              alignment: Alignment.center,
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}

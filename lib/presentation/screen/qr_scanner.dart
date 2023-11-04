import 'package:check_in_app/index.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  ScanQrScreenState createState() => ScanQrScreenState();
}

class ScanQrScreenState extends State<ScanQrScreen> {
  final TicketUcImpl _ticketUcImpl = TicketUcImpl();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _flashOn = false;

  @override
  void dispose() {
    _ticketUcImpl.qrViewController?.dispose();
    super.dispose();
  }

  void _onQrViewCreated(QRViewController controller) {
    print("create qr view");
    _ticketUcImpl.qrViewController = controller;

    _ticketUcImpl.qrViewController!.scannedDataStream.listen((event) async {
      print("scannedDataStream");

      if (_ticketUcImpl.isScanning) {
        setState(() {
          _ticketUcImpl.isScanning = false;
        });

        // Split the string by '/'
        List<String> parts = event.code!.split('/');

        // Get the last part of the list
        String id = parts.last;

        print(id);

        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          barrierColor: const Color.fromRGBO(130, 102, 224, 0.2),
          barrierDismissible: false,
          disableBackBtn: true,
        );

        _ticketUcImpl.getTicketData(id).then((value) {
          print("getTicketData");

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
            _ticketUcImpl.qrViewController!.resumeCamera().then((value) {
              setState(() {
                _ticketUcImpl.isScanning = true;
              });
            });
          });
        });

        _ticketUcImpl.qrViewController!.pauseCamera();
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
                _ticketUcImpl.qrViewController!.toggleFlash();
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
        ],
      ),
    );
  }
}

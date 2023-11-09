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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ticketUcImpl.qrViewController!.dispose();
    super.dispose();
  }

  void _handleScannedData(String scannedCode) async {
    if (_ticketUcImpl.isScanning) {

      setState(() {
        _ticketUcImpl.isScanning = false;
      });

      List<String> parts = scannedCode.split('/');
      String id = parts.last;

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

        _ticketUcImpl.redeemItems = _ticketUcImpl.ticketModel.value.data!.map((itemData) {
          return RedeemItemModel(
            orderId: itemData.orderId!,
            lineItem: itemData.lineItem!,
            qty: itemData.qty!,
          );
        }).toList();

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
              _ticketUcImpl.redeemItems = [];
              _ticketUcImpl.jsonDataRedeem = "";
            });
          });
        });
      });

      _ticketUcImpl.qrViewController!.pauseCamera();
    }
  }

  void _onQrViewCreated(QRViewController controller) {
    print("create qr view");
    _ticketUcImpl.qrViewController = controller;

    _ticketUcImpl.qrViewController!.scannedDataStream.listen((event) {
      print("scannedDataStream");
      _handleScannedData(event.code!);
    });
  }

  Widget _buildQrScanner() {
    return QRView(
      cameraFacing: CameraFacing.back,
      key: qrKey,
      onQRViewCreated: _onQrViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 25,
        borderLength: 50,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width / 1.25,
        cutOutBottomOffset: MediaQuery.of(context).size.height / 20,
      ),
    );
  }

  Widget _buildFlashButton() {
    return Positioned(
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
    );
  }

  Widget _buildPoweredByLogo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: poweredByKoompiLogoWhite(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ticketUcImpl.setBuildContext = context;

    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "QR Scanner"),
      body: Stack(
        children: [
          _buildQrScanner(),
          _buildFlashButton(),
          _buildPoweredByLogo(),
        ],
      ),
    );
  }
}

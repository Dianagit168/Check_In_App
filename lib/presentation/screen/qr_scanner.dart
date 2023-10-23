import 'package:check_in_app/index.dart';

class ScanQr extends StatefulWidget {

  final String eventTitle;

  const ScanQr({Key? key, required this.eventTitle}) : super(key: key);

  @override
  ScanQrState createState() => ScanQrState();
}

class ScanQrState extends State<ScanQr> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  
  QRViewController? _qrViewController;

  // Variable to hold the data from the QR code
  String _codeFromQRScanner = "None";


  // Callback function to pass the event to QRCodeCard
  Future<void> passEventToQRCodeCard(String code) async {    
    Map<String, dynamic> jsonMap = json.decode(code);
    
    // jsonMap['type'];

    // Use setState to trigger a rebuild of the widget tree
    setState(() {
      // Set the data to a variable in the state
      // This data will be accessible by QRCodeCard
      _codeFromQRScanner = jsonMap['type'];

    });

  }

  bool _flashOn = false;
  
  bool isScanning = true;

  void _onQrViewCreated(QRViewController controller) {
    _qrViewController = controller;

    try {
      _qrViewController!.scannedDataStream.listen((event) {
        if (isScanning) {
          isScanning = false; // Set the flag to false to indicate scanning has occurred

          _qrViewController!.pauseCamera().then((value) async {

            passEventToQRCodeCard(event.code!);
            
          }).whenComplete(() {
            // Resume camera after processing the event
            _qrViewController!.resumeCamera();
            isScanning = true;
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("QR create error: $e");
      }
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _qrViewController!.stopCamera();
    _qrViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "Run With Sai"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              qRCamW(),
    
              _qrResultCard(title: widget.eventTitle, type: _codeFromQRScanner,),
    
            ],
          ),
        ),
      ),
    );
  }

  Widget qRCamW() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height * 0.50).roundToDouble(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: QRView(
                  cameraFacing: CameraFacing.back,
                  key: qrKey,
                  onQRViewCreated: _onQrViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Theme.of(context).primaryColor,
                    borderRadius: 8,
                    borderLength: 36,
                    cutOutSize: 256,
                    cutOutBottomOffset: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: IconButton(
                  onPressed: () {
                    debugPrint("Controller is dead?: $_qrViewController");
                    _qrViewController!.toggleFlash();
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
            )
          ],
        )
      ),
    );
  }

  Widget _qrResultCard({required String title, required String type}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 4.0,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Crew: $title",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Type:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            label: Text(type)
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
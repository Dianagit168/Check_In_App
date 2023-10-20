import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  final GlobalKey qrKey = GlobalKey();
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void onQRViewCamera(QRViewController? controller) {
    this.controller = controller;
    controller!.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera),
              ),
              const SizedBox(
                height: 30,
              ),
              (result != null)
                  ? Text('Data is ${result!.code}')
                  : const Text('Please scan QR code')
            ],
          ),
        ),
      ),
    );
  }
}

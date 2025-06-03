import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late MobileScannerController controller;
  String? qrcodeValue;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      cameraResolution: Size(1920, 1080),
      detectionSpeed: DetectionSpeed.normal,
      formats: [BarcodeFormat.qrCode],
      torchEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(qrcodeValue ?? "")),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,

            onDetect: (capture) {
              final barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Scanned: ${barcode.rawValue}');
                setState(() {
                  qrcodeValue = barcode.rawValue;
                });
              }
            },
          ),

          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.dstIn, // Makes opaque areas transparent
                ),
                child: Lottie.asset(
                  'assets/json_animations/scanner-1.json',
                  height: 200,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => controller.toggleTorch(),
        child: const Icon(Icons.flashlight_on, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

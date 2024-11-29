import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? qrRawValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/logo_qr.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Scanner untuk mendeteksi QR
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;

              // Ambil data QR pertama yang terdeteksi
              for (final barcode in barcodes) {
                qrRawValue = barcode.rawValue;
                print('🔥 Barcode detected: ${barcode.rawValue}');
              }

              // Tampilkan hasil scan jika ada data
              if (qrRawValue != null && qrRawValue!.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("QR Code Detected! 🎉"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            qrRawValue!,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _shareText(qrRawValue!);
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.ios_share, size: 20),
                                SizedBox(width: 8),
                                Text("Share QR Code"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("QR Code is empty or not valid 😅")),
                );
              }
            },
          ),

          // Header info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/qr_scan_icon.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "QR SCANNER",
                      style: TextStyle(
                        color: Colors.lightBlue.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fungsi untuk share teks QR Code
  void _shareText(String text) async {
    try {
      await Share.share(
        "This is your QR result: $text 🚀",
        subject: "QR Code Scan Result",
      );
    } catch (e) {
      print('Error while share: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to share the text! Try again later 🙃")),
      );
    }
  }
}

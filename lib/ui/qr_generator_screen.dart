import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io'; // Import untuk File
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan direktori penyimpanan

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrLink;
  bool isGenerated = false;
  final ScreenshotController _screenshotController = ScreenshotController();

  // Fungsi untuk membagikan QR Code
  void _shareQRCode() async {
    if (qrLink != null) {
      // Ambil screenshot QR Code
      final Uint8List? imageBytes =
          await _screenshotController.captureFromWidget(
        PrettyQr(
          data: qrLink!,
          size: 200,
          roundEdges: true,
          elementColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      );

      // Jika screenshot berhasil
      if (imageBytes != null) {
        // Simpan file gambar ke penyimpanan lokal
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/qr_code.png';

        final imageFile = File(imagePath)..writeAsBytesSync(imageBytes);

        // Mengonversi File ke XFile untuk digunakan pada share
        final xFile = XFile(imageFile.path);

        // Bagikan file gambar QR Code
        await Share.shareXFiles(
          [xFile], // Bagikan file gambar QR Code
          text: "Here is my QR code! Let's create it with QSCAN",
        );
      }
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField untuk link QR
            TextField(
              decoration: InputDecoration(
                labelText: "Link to generate",
                hintText: "Enter the URL",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color(0xFFE5EDFF),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                prefixIcon: const Icon(Icons.link),
              ),
              onChanged: (value) {
                qrLink = value;
              },
            ),
            const SizedBox(height: 24),
            // Tombol Generate
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "Generate QR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (qrLink != null && qrLink!.isNotEmpty) {
                    setState(() {
                      isGenerated = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter a valid link!")),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            // Area hasil QR Code
            Expanded(
              child: Center(
                child: isGenerated
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Screenshot(
                                  controller: _screenshotController,
                                  child: PrettyQr(
                                    data: qrLink!,
                                    size: 300,
                                    roundEdges: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Tombol Share
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: _shareQRCode,
                                  icon: Icon(Icons.share),
                                  label: Text("Share QR Code",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade900,
                                    iconColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    )
                    : const Text(
                        "Your QR Code will appear here!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

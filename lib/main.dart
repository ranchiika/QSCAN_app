import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/home_screen.dart';
import 'package:qr_scanner/ui/qr_generator_screen.dart';
import 'package:qr_scanner/ui/qr_scanner_screen.dart';
import 'package:qr_scanner/ui/splash.dart';

void main() {
  runApp(const QrScannerApp());
}

class QrScannerApp extends StatelessWidget {
  const QrScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QR Scanner App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => SplashScreen(),
        "/home" : (context) => HomeScreen(),
        "/scanner" : (context) => QrScannerScreen(),
        "/generator" : (context) => QrGeneratorScreen()
      },
    );
  }
}
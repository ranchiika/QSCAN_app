import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Logo Image
            Image.asset('assets/images/logo_qr.png',
            width: 200,
            height: 200,),
            // end Logo Image

            // QR Scanner button
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/scanner");
              },
              child: FittedBox(
                child: Container(
                   padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Warna bayangan
                        spreadRadius: 5, // Jangkauan bayangan
                        blurRadius: 7, // Keburaman bayangan
                        offset: Offset(0, 6), // Posisi bayangan (x, y)
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/qr_scan_icon.png'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("QR SCANNER",
                            style: TextStyle(
                              color: Colors.lightBlue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                            Text("Try to scan your QR Code",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 15
                            ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // QR SCanner end

            SizedBox(height: 30),

            // QR Generate button
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/generator");
              },
              child: FittedBox(
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Warna bayangan
                        spreadRadius: 5, // Jangkauan bayangan
                        blurRadius: 7, // Keburaman bayangan
                        offset: Offset(0, 6), // Posisi bayangan (x, y)
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/qr_gen_icon.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("QR GENERATE",
                          style: TextStyle(
                            color: Colors.lightBlue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                          Text("Make your own QR Code",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 15
                          ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
            // QR Generate end
          ],
        ),
      ),
    );
  }
}
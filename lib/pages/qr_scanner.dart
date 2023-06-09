import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/icon_button_mode.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr مسح ', style: CustomTextStyle.f18w),
        centerTitle: true,
        actions: const [IconButtonn()],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _scanBarcode,
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                ElevatedButton(
                  onPressed: () => scanQR(),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width / 1.4,
                      MediaQuery.of(context).size.height / 20,
                    ),
                  ),
                  child: const Text("Scan "),
                ),
              ],
            ),
          );
        },
      ),
      drawer: const Drawerr(),
    );
  }
}

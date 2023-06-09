import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_easy_permission/easy_permissions.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'package:iraq_bank/controller/ecc.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/icon_button_mode.dart';

const _permissions = [Permissions.READ_EXTERNAL_STORAGE, Permissions.CAMERA];

const _permissionGroup = [PermissionGroup.Camera, PermissionGroup.Photos];

class BarcodeScaning extends StatefulWidget {
  const BarcodeScaning({super.key});

  @override
  _BarcodeScaningState createState() => _BarcodeScaningState();
}

class _BarcodeScaningState extends State<BarcodeScaning> {
  late FlutterScankit scanKit;

  String email = "";
  String account = "";

  @override
  void initState() {
    super.initState();
    scanKit = FlutterScankit();
    scanKit.addResultListen((val) {
      var list = val.split(' ');
      String l1 = list[0];
      String l2 = list[1].replaceAll(',', '');

      setState(() {
        email = Ecc().decryption(l1);
        account = Ecc().decryption(l2);
      });
    });
  }

  @override
  void dispose() {
    scanKit.dispose();
    super.dispose();
  }

  Future<void> startScan() async {
     final startTime3 = DateTime.now(); //++++++++++
    try {
      await scanKit.startScan(scanTypes: [ScanTypes.ALL]);
    } on PlatformException {}
     final endTime3 = DateTime.now(); // ======
    final elapsedMilliseconds3 = endTime3.difference(startTime3).inMilliseconds;
    print('Elapsed time 3 : $elapsedMilliseconds3 milliseconds++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'صفحة فك تشفير البيانات',
          style: CustomTextStyle.f20b,
        ),
        centerTitle: true,
        actions: const [IconButtonn()],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'البيانات التي تم فك تشفيرها',
              style: TextStyle(fontSize: 20),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(email, style: const TextStyle(fontSize: 30)),
                      const SizedBox(height: 20),
                      Text(account, style: const TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              child: const Text("QR Code مسح"),
              onPressed: () async {
                if (!await FlutterEasyPermission.has(perms: _permissions, permsGroup: _permissionGroup)) {
                  FlutterEasyPermission.request(perms: _permissions, permsGroup: _permissionGroup);
                } else {
                  startScan();
                }
              },
            ),
          ],
        ),
      ),
      drawer: const Drawerr(),
    );
  }
}

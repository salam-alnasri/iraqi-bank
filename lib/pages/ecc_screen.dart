import 'dart:async';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:iraq_bank/controller/ecc.dart';

import 'package:iraq_bank/widget/drawerr.dart';
import 'package:iraq_bank/widget/icon_button_mode.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ECC extends StatefulWidget {
  const ECC({super.key});

  @override
  State<ECC> createState() => _ECCState();
}

class _ECCState extends State<ECC> {
  //------------------------------------------
  TextEditingController acounttext = TextEditingController();
  TextEditingController amounttext = TextEditingController();

  String cipherTextBankAccount = '';
  String cipherTextamount = '';

//-------------------------------------------------
  bool _isQRGenerated = false;
  bool _isEncryption = false;

  //---------------------------------------------
  String _qrData = '';

//save qr functionality
  final controller = ScreenshotController();

  saveQR(Uint8List image) async {
    final time = DateTime.now().toIso8601String().replaceAll('.', '_').replaceAll(':', '_');
    final name = "Qr _$time";
    final result = await ImageGallerySaver.saveImage(image, name: name);
  }

  //------------------------------------------ ECC Function

  void encryption() {
     final startTime1 = DateTime.now(); //++++++++++
    setState(() {
      cipherTextBankAccount = Ecc().encryption(acounttext.text);
      cipherTextamount = Ecc().encryption(amounttext.text);
      _isEncryption = true;
    });
     final endTime1 = DateTime.now(); // ======
    final elapsedMilliseconds1 = endTime1.difference(startTime1).inMilliseconds;
    print('Elapsed time 1 : $elapsedMilliseconds1 milliseconds');
  }

  //------------------------------------------
 
  void qrData() {
   final startTime2 = DateTime.now(); //++++++++++

    setState(() {
      _qrData = '$cipherTextBankAccount ,$cipherTextamount,';

      _isQRGenerated = true;
    });
   final endTime2 = DateTime.now(); // ======
    final elapsedMilliseconds2 = endTime2.difference(startTime2).inMilliseconds;
    print('Elapsed time 2 : $elapsedMilliseconds2 milliseconds');
  }

  //-----------------------------------------
  final timer = Timer(const Duration(milliseconds: 100), () => print('Timer finished'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" تشفير المعلومات المصرفية"),
        centerTitle: true,
        actions: const [IconButtonn()],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width / 1.7,
              child: _isQRGenerated
                  ? Screenshot(
                      controller: controller,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1),
                        ),
                        child: QrImage(
                          data: _qrData,
                          size: MediaQuery.of(context).size.height / 5,
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(" اضغظ على زر توليد رمز الاستجابة السريعة ", textAlign: TextAlign.center),
                    ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // Text(cipherTextBankAccount),
                // Text(cipherTextamount),
                ////////////////////////////////////////////
                TextField(
                  controller: acounttext,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ادخل رقم الحساب البنكي ",
                    suffixIcon: Icon(Icons.account_balance),
                  ),
                ),
                ////////////////////////////////////////////////
                SizedBox(height: MediaQuery.of(context).size.height / 99),
                TextField(
                  controller: amounttext,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ادخل قيمة المبلغ",
                    suffixIcon: Icon(Icons.currency_exchange),
                  ),
                ), /////////////////////////////////////////
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 99),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 50, left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    encryption();
                    //  ECC Function <<-------------------------->>

                    Get.snackbar(
                      "",
                      "تم تشفير النص بنجاح",
                      duration: const Duration(seconds: 3),
                    );
                  },
                  child: const Text("تشفير", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 50, left: 50),
            child: ElevatedButton(
              onPressed: () {
                if (cipherTextamount == null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: ' الرجاء قم بتشفير البيانات اولا',
                    btnOkText: 'رجوع',
                    btnOkOnPress: () {
                      acounttext.clear();
                      amounttext.clear();
                    },
                  ).show();
                  return;
                }

                qrData(); //-------------------------------------------Qr Data

                Get.snackbar(
                  "",
                  "تم توليد رمز الاستجابة السريع",
                  duration: const Duration(seconds: 3),
                );
                acounttext.clear();
                amounttext.clear();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.of(context).size.width / 1.4,
                  MediaQuery.of(context).size.height / 18,
                ),
              ),
              child: Text(
                _isQRGenerated ? 'تم توليد رمز الاستجابة السريعة ' : "اضغظ  لتوليد رمز الاستجابة السريعة",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 50, left: 50, bottom: 10),
            child: ElevatedButton(
              onPressed: () async {
                final image = await controller.capture();
                if (image != null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'تم الحفظ بنجاح',
                    btnOkOnPress: () {},
                  ).show();

                  //++++++++++++++++++++++++++++++++++++++++

                  saveQR(image); // --------------------------------------------------- Save Qr Function
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                MediaQuery.of(context).size.width / 1.4,
                MediaQuery.of(context).size.height / 18,
              )),
              child: const Text('حفظ في الهاتف '),
            ),
          ),
        ],
      ),
      drawer: const Drawerr(),
    );
  }
}

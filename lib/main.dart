import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iraq_bank/pages/login_screen.dart';

import 'controller/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // استدعاء وتهيئة الفايربيس
  await Firebase.initializeApp(); // استدعاء وتهيئة الفايربيس
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_f);
  runApp(const BankProject());
}

Future<void> _f(RemoteMessage message) async {}

class BankProject extends StatelessWidget {
  const BankProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Iraq Bank",

      debugShowCheckedModeBanner: false, // لالغاء ضهور شريط وضع اللافتة
      home:
          //const BottomNB(),
          const Login(), // الصفحة الاولى التي يتم عرضها عند بدء التطبيق هي صفحة انشاء الحساب
      theme: Themes.customLightTheme, // الثيم الافتراضي عند بدء التطبيق هو الثيم الابيض
    );
  }
}

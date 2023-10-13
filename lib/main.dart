import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/themes.dart';
import 'pages/login_screen.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // استدعاء وتهيئة الفايربيس
  await Firebase.initializeApp(); // استدعاء وتهيئة الفايربيس
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_f);
  runApp(BankProject());
}

Future<void> _f(RemoteMessage message) async {}

class BankProject extends StatelessWidget {
  BankProject({Key? key}) : super(key: key);

  //===============================================================  الكود رقم 1 تسجيل الخروج التلقائي
  //=============================================================== المتغيرات الاساسية
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get navigator => _navigatorKey.currentState!;
  final sessionStateStream = StreamController<SessionState>();
//============================================================

  @override
  Widget build(BuildContext context) {
    //================================================================== الكود رقم 2 تسجيل الخروج التلقائي
    //================================================================== متغيرات المدة الزمنية
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 1),
      invalidateSessionForUserInactivity: const Duration(seconds: 90),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      //  توقف عن الاستماع، لأن المستخدم سيكون بالفعل في صفحة المصادقة
      sessionStateStream.add(SessionState.stopListening);
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout التعامل مع مهلة المستخدم غير النشطة

        Get.off(() => Login(
              sessionStateStream: sessionStateStream,
            ));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        //  التعامل مع تطبيق المستخدم المفقود مهلة التركيز
        Get.off(() => Login(sessionStateStream: sessionStateStream));
      }
    });
    return SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: sessionConfig,
      sessionStateStream: sessionStateStream.stream,
//=============================================================
      child: GetMaterialApp(
        title: "Iraq Bank",
        debugShowCheckedModeBanner: false, // لالغاء ضهور شريط وضع اللافتة
        // الصفحة الاولى التي يتم عرضها عند بدء التطبيق هي صفحة انشاء الحساب
        home: Login(sessionStateStream: sessionStateStream), // الكود رقم 3),

        theme: Themes.customLightTheme, // الثيم الافتراضي عند بدء التطبيق هو الثيم الابيض
      ),
    );
  }
}

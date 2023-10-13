import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iraq_bank/controller/textstyle.dart';
import 'package:iraq_bank/pages/card_screen.dart';
import 'package:iraq_bank/pages/ecc_screen.dart';
import 'package:iraq_bank/pages/home_screen.dart';
import 'package:iraq_bank/pages/login_screen.dart';
import 'package:iraq_bank/pages/person_screen.dart';
import 'package:iraq_bank/pages/qr_scanner.dart';
import 'package:iraq_bank/widget/button_mode.dart';

import 'dart:async';

class Drawerr extends StatelessWidget {
  const Drawerr({super.key});

  //--------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 40),

              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "images/1111.jpg",
                        ),
                        radius: 60),
                  ),
                  Text("NOOR - JHY", style: CustomTextStyle.f18w),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 40),
              //_________________________________________________
              TextButton.icon(
                icon: const Icon(Icons.home),
                label: const Text("Home Page"),
                onPressed: () {
                  Get.to(() => const HomeScreen());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 90),
              //------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan Qr"),
                onPressed: () {
                  Get.to(() => const QrScanner());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 90),

              //----------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.account_box),
                label: const Text("Person Page"),
                onPressed: () {
                  Get.to(() => const PersonPage());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              //-------------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.credit_card),
                label: const Text("My Card"),
                onPressed: () {
                  Get.to(() => const CardScreen());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              //---------------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.security),
                label: const Text("ECC"),
                onPressed: () {
                  Get.to(() => const ECC());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              //----------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text("settings"),
                onPressed: () {
                  Get.snackbar(
                    "تنبيه",
                    "هذه الخدمة غير متاحة بعد",
                    backgroundColor: Colors.white,
                    icon: const Icon(
                      Icons.priority_high_rounded,
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              //-----------------------------------------------------
              TextButton.icon(
                icon: const Icon(Icons.info),
                label: const Text("info"),
                onPressed: () {
                  Get.snackbar(
                    "تنبيه",
                    "هذه الخدمة غير متاحة بعد",
                    backgroundColor: Colors.white,
                    icon: const Icon(
                      Icons.priority_high_rounded,
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              const ButtonMode(),

              //----------------------------------------------------
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              TextButton.icon(
                onPressed: () {
                  // Get.off(() => Login(sessionStateStream: sessionStateStream));
                },
                icon: const Icon(Icons.logout),
                label: const Text("LogOut"),
              )
            ],
          )),
    );
  }
}

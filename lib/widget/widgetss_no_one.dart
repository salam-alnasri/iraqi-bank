import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iraq_bank/messages/receive.dart';
import 'package:iraq_bank/pages/tranasfer_history.dart';

import '../messages/send.dart';

Widget a1 = Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
    onPressed: () {
      Get.to(() => const Send());
    },
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(110, 90),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(height: 10),
        Icon(Icons.monetization_on_outlined, size: 30),
        Text("تحويل اموال"),
      ],
    ),
  ),
);
//========================================

Widget a2 = Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
    onPressed: () {
      Get.to(() => const TranasferHistory());
    },
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(110, 90),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(height: 10),
        Icon(Icons.list_alt, size: 30),
        Text("تاريخ المعاملات "),
      ],
    ),
  ),
);
//======================================

Widget a3 = Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
    onPressed: () {
      Get.to(() => const Res());
    },
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(110, 90),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(height: 10),
        Icon(Icons.notification_important, size: 30),
        Text("الاشعارات"),
      ],
    ),
  ),
);

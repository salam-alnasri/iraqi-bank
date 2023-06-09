import 'package:flutter/material.dart';
import 'package:iraq_bank/pages/barcode_scaning.dart';
import 'package:iraq_bank/pages/card_screen.dart';
import 'package:iraq_bank/pages/ecc_screen.dart';
import 'package:iraq_bank/pages/home_screen.dart';
import 'package:iraq_bank/pages/person_screen.dart';
import 'package:iraq_bank/pages/qr_scanner.dart';

class BottomNB extends StatefulWidget {
  const BottomNB({super.key});

  @override
  BottomNBState createState() => BottomNBState();
}

class BottomNBState extends State<BottomNB> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PersonPage(),
    CardScreen(),
    QrScanner(),
    ECC(),
    BarcodeScaning(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      //
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedIconTheme: const IconThemeData(size: 40),
        // selectedFontSize: 16,
        // unselectedFontSize: 14,
        //
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الصفحة الشخصية'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'البطاقات'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Qr مسح '),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'ECC'),
          BottomNavigationBarItem(icon: Icon(Icons.lock_open_rounded), label: 'ECC Dec'),
        ],
        currentIndex: _selectedIndex,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

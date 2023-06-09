import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iraq_bank/controller/themes.dart';

class IconButtonn extends StatefulWidget {
  const IconButtonn({super.key});

  @override
  IconButtonnState createState() => IconButtonnState();
}

class IconButtonnState extends State<IconButtonn> {
  String _buttonLabel = 'Dark Mode';
  IconData _buttonIcon = Icons.dark_mode;

  void _onButtonPressed() {
    setState(() {
      if (_buttonLabel == 'Light Mode') {
        _buttonLabel = 'Dark Mode';
        _buttonIcon = Icons.dark_mode;
      } else {
        _buttonLabel = 'Light Mode';
        _buttonIcon = Icons.light_mode;
      }
    });
    if (Get.isDarkMode) {
      Get.changeTheme(
        Themes.customLightTheme,
      );
    } else {
      Get.changeTheme(
        Themes.customDarkTheme,
      );
    }
  }

  //--------------------------------

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_buttonIcon),
      onPressed: _onButtonPressed,
    );
  }
}

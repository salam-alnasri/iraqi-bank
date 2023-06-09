import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iraq_bank/controller/themes.dart';

class ButtonMode extends StatefulWidget {
  const ButtonMode({super.key});

  @override
  ButtonModeState createState() => ButtonModeState();
}

class ButtonModeState extends State<ButtonMode> {
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
    return TextButton.icon(
      icon: Icon(_buttonIcon),
      label: Text(_buttonLabel),
      onPressed: _onButtonPressed,
    );
  }
}

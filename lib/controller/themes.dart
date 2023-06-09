import 'package:flutter/material.dart';

class Themes {
  //---------------------------------------------------------------------
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    // Drawer
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff2a9d8f),
      elevation: 0,
    ),
    //--------------------------------------- AppBar
    appBarTheme: const AppBarTheme(
      color: Color(0xff2a9d8f),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xfffefae0),
      ),
    ),
    //---------------------------- Card
    cardTheme: const CardTheme(
      shadowColor: Colors.black,
      elevation: 10,
      color: Colors.white,
    ),
    //------------------------------------------ Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff264653),
        foregroundColor: const Color(0xfffefae0),
      ),
    ),
    //------------------------------------------------ Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xfffefae0),
      ),
    ),

    //------------------------------------------------------ FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xff212529),
    ),

    // useMaterial3: true,
//------------------------------------------------------ BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.teal,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white,
    ),
    //-------------------------------------------------
    primaryColor: const Color(0xff2a9d8f),
    focusColor: Colors.cyan[900],
    shadowColor: Colors.teal,
    dividerColor: Colors.black,
  );
  //==============================================================
  //==============================================================
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff495057),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff495057),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xfffefae0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xfffefae0),
        foregroundColor: const Color(0xff212529),
      ),
    ),
    //---------------------------------------
    cardTheme: const CardTheme(color: Color(0xff212529)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    primaryColor: const Color(0xff495057),
    shadowColor: Colors.white,
    focusColor: Colors.cyan[900],

    // scaffoldBackgroundColor: const Color(0xff2b2d42),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    ),

    // useMaterial3: true,
  );
}

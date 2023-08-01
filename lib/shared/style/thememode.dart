import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color.dart';

ThemeData lightthem=ThemeData(
  primarySwatch:defaultcolor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight:FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      elevation: 0,
      systemOverlayStyle:(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ))
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultcolor,
      elevation: 20
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:defaultcolor,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      )
  ),
);
ThemeData? darkthem= ThemeData(
  scaffoldBackgroundColor:HexColor('333739'),
  primarySwatch:defaultcolor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: HexColor('333739'),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight:FontWeight.bold
      ),
      systemOverlayStyle:(SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness:Brightness.light,
      ))

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('333739'),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
      )
  ),
);
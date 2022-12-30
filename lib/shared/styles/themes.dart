import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

var lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    color: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Jannah'),
  ),
);
var darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    color: HexColor('333739'),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Jannah'),
  ),
);

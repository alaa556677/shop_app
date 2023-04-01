import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/shared_preferences.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
  fontFamily: 'lato',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 0,
    backgroundColor: Colors.white
  ),
);

String token= '';





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../shared.components/constants.dart';

ThemeData  lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'jannah',
  textTheme:TextTheme(
      bodyText2: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontFamily: 'jannah',
      ),
    subtitle2: TextStyle(
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4
    ),
  ) ,

  iconTheme: IconThemeData(
    color: Colors.black,
  ),

  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(
      fontSize: 13,
    ),
    selectedLabelStyle:TextStyle(
      fontWeight: FontWeight.w400,
    ) ,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    showSelectedLabels: true,
    selectedIconTheme: IconThemeData(
      size: 30,
    ),
  ),
 // scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleSpacing: 20,
    actionsIconTheme:IconThemeData(
      color: Colors.black,
    ) ,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'jannah',
    ),
    backwardsCompatibility:false,
    systemOverlayStyle:SystemUiOverlayStyle(
    statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),

    backgroundColor: Colors.white,
    elevation: 0,
  ),
);


ThemeData darkTheme=ThemeData(

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor:  HexColor(
      '2e2e2e',
    ),
    unselectedItemColor:Colors.grey,
    unselectedLabelStyle: TextStyle(
      fontSize: 20,
    ),
    selectedLabelStyle:TextStyle(
      fontWeight: FontWeight.bold,
    ) ,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    showSelectedLabels: true,
    selectedIconTheme: IconThemeData(
      size: 50.0,
    ),
  ),
  scaffoldBackgroundColor: HexColor(
    '2e2e2e',
  ),
  textTheme:TextTheme(
      bodyText2: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      )
  ) ,

  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme:IconThemeData(
      color: Colors.white,
    ) ,
    backgroundColor: HexColor(
      '2e2e2e',
    ),
    backwardsCompatibility:false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
);

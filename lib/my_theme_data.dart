
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';

class MyThemeData {
  static final ThemeData LightTheme = ThemeData(
    primaryColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.orangeColor,
      backgroundColor: AppColors.greyColor ,
    ),
    textTheme: TextTheme(

   bodyLarge: TextStyle(
     fontSize: 22 ,  color: AppColors.whiteColor ,
     fontWeight: FontWeight.bold,
   ),

      bodyMedium: TextStyle(
        fontSize: 20 , color: AppColors.greyColor ,
        fontWeight: FontWeight.bold,
      )
    )
  );
}

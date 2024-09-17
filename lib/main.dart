import 'package:flutter/material.dart';
import 'package:movies/main_page/main_page.dart';
import 'package:movies/my_theme_data.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.routename ,
      routes: {
       MainPage.routename : (context) => MainPage()
      },
      theme: MyThemeData.LightTheme,
    );
  }
}

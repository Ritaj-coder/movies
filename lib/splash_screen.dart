
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/main_page/main_page.dart';


class SplashScreen extends StatelessWidget {
  static const String routename="splashScreen";

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacementNamed(MainPage.routename);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 100,),
            Image.asset('assets/images/movies.png',
              width: 168,
              height: 187,),
            Column(
              children: [
                Image.asset('assets/images/route.png',
                  width: 128,
                  height: 128,),
                Text('supervised by Mohamed Nabil',
                    style:
                    TextStyle(
                        fontFamily:'inter',
                        fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.orangeColor
                    ))
              ],)
            //   Padding(
            //   padding: const EdgeInsets.fromLTRB(100,250,0,0),
            //   child:
            // ),
            //  Padding(
            //   padding: const EdgeInsets.fromLTRB(100.74,0,0,0),
            //    child: Text('supervised by Mohamed Nabil',
            //                   style:
            //                   TextStyle(
            //                     fontFamily:'inter',
            //                     fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.orangeColor
            //                   )),
            //  )
          ],
        ),
      ),
    );
  }
}
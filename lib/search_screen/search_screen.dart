import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.searchbackColor,
              borderRadius: BorderRadius.circular(25)
            ),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.search , color: AppColors.whiteColor,),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search" ,
                      hintStyle: TextStyle(color: AppColors.whiteColor),
                      border: InputBorder.none
                    ),
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                )
              ],
            ),
          ),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
              child: Image.asset("assets/images/iconmovie.png",),),
          SizedBox(height: 10,),
          Text("No Movies Found", style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    );
  }
}
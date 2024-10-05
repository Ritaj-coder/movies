
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:readmore/readmore.dart';

import '../data/model/Response/MoreLikeThisResponse.dart';


class MoreLikeDetails extends StatelessWidget {

  static const String routename = 'morelike' ;

  static String baseUrl="https://image.tmdb.org/t/p/original";

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)!.settings.arguments as Results ;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text("Movie Details"),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.orangeColor,
        titleTextStyle: TextStyle(
            fontSize: 20 ,
            color: AppColors.orangeColor
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.greyColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network("$baseUrl${args.posterPath}",
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 500,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Movie Name : ${args.originalTitle}",style:
              Theme.of(context).textTheme.bodyLarge,
              ) ,
              SizedBox(height: 10,),
              Text("OverView : ", style:
              Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 10,),
              ReadMoreText(
                args.overview??"",
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: AppColors.orangeColor,
                trimCollapsedText: 'Read More',
                trimExpandedText: 'Read Less',
                moreStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: AppColors.orangeColor),
              ),
              SizedBox(height: 10,),
              Text("Release Date : ${args.releaseDate}",style:
              Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 10,),
              Text("Popularity : ${args.popularity}",style:
              Theme.of(context).textTheme.bodyLarge),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Vote Avg : ${args.voteAverage}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.whiteColor
                  ),),
                  Icon(Icons.star , color: Colors.yellow,)
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangeColor ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      )
                  ),
                  onPressed: (){

                  }, child: Text("WATCH NOW",style:
              Theme.of(context).textTheme.bodyLarge,))
            ],
          ),
        ),
      ),
    );
  }
}
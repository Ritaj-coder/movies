
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:readmore/readmore.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';


class MoviesContent extends StatelessWidget {

  Results moviesdata ;
  MoviesContent({required this.moviesdata});

  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "$baseImageUrl${moviesdata.posterPath}",
            fit: BoxFit.fill,
            width: 180,
            height: 240,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title : ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.whiteColor
              ), ),
              Text(moviesdata.originalTitle??"", maxLines: 1),
              SizedBox(height: 4,),
              Text("OverView : ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.whiteColor
              ),),

            ReadMoreText(
              moviesdata.overview??"",
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: AppColors.orangeColor,
              trimCollapsedText: 'Read More',
              trimExpandedText: 'Read Less',
              moreStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
              color: AppColors.orangeColor),

            ),

              SizedBox(height: 4,),
              Text("Popularity : ${moviesdata.popularity}"
                ,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: AppColors.whiteColor
      ),),
              SizedBox(height: 4,),
              Text("Release Date : ${moviesdata.releaseDate}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.whiteColor
              ),),
              SizedBox(height: 4,),
              Row(
                children: [
                  Text("Vote Avg : ${moviesdata.voteAverage}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.whiteColor
                  ),),
                  Icon(Icons.star , color: Colors.yellow,)
                ],
              )
            ],
        ),
          )

        ],
      ),
    );
  }
}

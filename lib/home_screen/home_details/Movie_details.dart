
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_state.dart';
import 'package:movies/home_screen/home_details/description_movie_details.dart';

import '../../data/model/Response/DetailsResponse.dart';


class MovieDetails extends StatelessWidget {

  static const String routename = 'details' ;
  List <Genres> items = [];
  List<DetailsResponse>? detailsList = [] ;
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MovieDetailsViewModel,MovieDetailsStates>(
      bloc: viewModel..getMovieDetails(),
      builder: (context,state){
        String appBarTitle = "Loading...";
        var year ;
        String? runtimeText ;
        String? OverView;
        num? Vote;
        String? backDrop ;
        bool errorCase = false;
        if (state is MovieDetailsSuccessState) {
          appBarTitle = viewModel.title ?? "Movie Title";
          year = viewModel.year;
          int? hours = viewModel.hours;
          int? minutes = viewModel.minutes;
          runtimeText = '${hours}h ${minutes}m';
          OverView = viewModel.overview;
          Vote = viewModel.vote;
          items = viewModel.genres!;
          backDrop = viewModel.backdrop_path;

        }
        else if(state is MovieDetailsErrorState){
          errorCase = true ;
          appBarTitle = state.errorMessage ;
          year = "No Year Date" ;
          runtimeText = "No Film Have Found" ;
          OverView = "No Film Have Found";
          Vote = 0;
          state.errorMessage ;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.greyColor,
            title: Text(
              appBarTitle,
              // "Dora and the lost city of gold",
              style: TextStyle(color: AppColors.whiteColor),
            ),
            centerTitle: false,
            iconTheme: IconThemeData(
              color: AppColors.whiteColor,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 1),
                        child:
                        Image.network(
                          '$baseImageUrl${backDrop}',
                          width: double.infinity,
                          height: 217,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(176, 107, 0, 0),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.whiteColor
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(5),
                          iconSize: 50,
                          icon: const Icon(
                            color: Color.fromARGB(88, 15, 15, 15),
                            Icons.play_arrow,
                          ),
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                errorCase == false ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(appBarTitle,
                    textAlign:TextAlign.right,
                    style:TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                    ),),
                ) :
                Padding(
                  padding: EdgeInsets.only(right: 20,left: 20),
                  child: Text(appBarTitle,
                    style:TextStyle(
                        fontSize: 20,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                    ),
                  ),
                ),
                //--------------------------------------
                errorCase == false ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${year ?? ''}  $runtimeText',
                    textAlign:TextAlign.right,
                    style:TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffB5B4B4)
                    ),),
                ):
                Padding(
                  padding:  EdgeInsets.only(right: 150),
                  child: Text('${year ?? ''}  $runtimeText',
                    style:TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xffB5B4B4)
                    ),),
                ),
                //--------------------------------------
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(21, 11, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),

                          child: Image.network(
                            viewModel.poster_image != null && viewModel.poster_image!.isNotEmpty
                                ? '$baseImageUrl${viewModel.poster_image}'
                                : 'path/to/your/placeholder_image.png',
                            width: 129,
                            height: 199,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top:-5,
                          left: 4,
                          child:IconButton(
                            onPressed: () {
                            },
                            icon: Icon(
                              Icons.bookmark,
                              color: Color.fromARGB(217, 81, 79, 79),
                              size: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Container(
                            width: 11,
                            height: 11,
                            child: Icon(
                              Icons.add,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Flexible(child: DescriptionMovieDetails(classification: items,overView: OverView ?? "No overview available",vote: Vote,)) ,
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  width:455.62 ,
                  height: 220,
                  //height: 246,
                  color: AppColors.greyColor,
                  /*
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(19, 15.13, 0, 0),
                        child: Text('More Like This',
                            style:
                            TextStyle(
                                fontFamily:'inter',
                                fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                            )),),

                  //   RecomendedOrMoreLikeSection(list: viewModel.detailsList ??[],)
                     // Text(appBarTitle)
                    ],
                  ),

                   */
                )
              ],
            ),
          ),
        );

      },
    );
  }
}

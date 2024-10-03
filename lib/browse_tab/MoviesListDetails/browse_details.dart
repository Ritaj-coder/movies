
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/browse_tab/MoviesListDetails/cubit/movie_details_cubit.dart';
import 'package:movies/browse_tab/MoviesListDetails/cubit/movie_details_state.dart';
import 'package:movies/browse_tab/MoviesListDetails/movies_content.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';


class BrowseDetails extends StatelessWidget {

  static const String routename = "MoviesDetails" ;
  MovieOfCategoriesViewModel viewModel = MovieOfCategoriesViewModel();

  @override
  Widget build(BuildContext context) {
    final genreId = ModalRoute.of(context)!.settings.arguments as int ;
    return BlocProvider(
      create: (context)=> viewModel..getAllMovies(genreId),
      child: BlocBuilder<MovieOfCategoriesViewModel,MovieOfCategoriesState>(
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                title: const Text("Movies Available"),
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.orangeColor,
                titleTextStyle: TextStyle(
                    fontSize: 20 ,
                    color: AppColors.orangeColor
                ),
              ),
              body: state is MovieOfCategoriesSuccessState ?

              ListView.builder(
                itemCount: state.moviesdetailsResponse.results!.length,
                itemBuilder: (context,index){

                  final movie = state.moviesdetailsResponse.results![index];
                  if (movie.genreIds!.contains(genreId)) {
                    return MoviesContent(moviesdata: movie);
                  } else {
                    return Container();
                  }
                },
              ) :
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ),
                  )
          );
        },

      ),
    );
  }
}

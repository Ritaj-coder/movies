import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_state.dart';
import 'package:movies/home_screen/home_details/description_movie_details.dart';
import 'package:movies/home_screen/more_likesection.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';
import '../../data/model/Response/DetailsResponse.dart';

class MovieDetails extends StatelessWidget {
  static const String routename = 'details';
  final int movieId;

  MovieDetails({required this.movieId});
  List<Genres> items = [];
  List<DetailsResponse>? detailsList = [];
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistViewModel>();
    // Map Results to Movie
    Movie movie = Movie(
      id: viewModel.id.toString(), // Convert int to String if needed
      title: viewModel.title ?? 'Unknown Title',
      posterUrl: viewModel.poster_image ?? '',
      releaseYear: viewModel.year ?? 'Unknown',
      voteAverage: viewModel.vote ?? 0.0,
    );
    return BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
      bloc: viewModel..getMovieDetails(movieId),
      builder: (context, state) {
        String appBarTitle = "Loading...";
        var year;
        String? runtimeText;
        String? OverView;
        num? Vote;
        String? backDrop;
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
        else if (state is MovieDetailsErrorState) {
          errorCase = true;
          appBarTitle = state.errorMessage;
          year = "No Year Date";
          runtimeText = "No Film Found";
          OverView = "No Film Found";
          Vote = 0;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            title: Text(
              appBarTitle,
              style: TextStyle(color: AppColors.whiteColor),
            ),
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
                        child: CachedNetworkImage(
                          imageUrl: '$baseImageUrl$backDrop',
                          // imageUrl: '$baseImageUrl${viewModel.poster_image ?? ''}',
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
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
                          color: AppColors.whiteColor,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.all(5),
                          iconSize: 50,
                          icon: const Icon(
                            color: Color.fromARGB(88, 15, 15, 15),
                            Icons.play_arrow,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                errorCase == false
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    appBarTitle,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    appBarTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                //--------------------------------------
                errorCase == false
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${year ?? ''}  $runtimeText',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5B4B4),
                    ),
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text(
                    '${year ?? ''}  $runtimeText',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB5B4B4),
                    ),
                  ),
                ),
                //--------------------------------------
                Row(
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(21, 11, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:viewModel.poster_image != null &&
                                  viewModel.poster_image!.isNotEmpty
                                  ? '$baseImageUrl${viewModel.poster_image}'
                                  : 'path/to/your/placeholder_image.png',
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              width: 129,
                              height: 199,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -5,
                            left: 4,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark,
                                color: Color.fromARGB(217, 81, 79, 79),
                                size: 40,
                              ),
                            ),
                            //         child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
                            //           bloc: watchlistCubit..loadWatchlist(),
                            // builder: (context, watchlistState) {
                            //   if (watchlistState is WatchlistSuccessState) {
                            //     // Check if the movie is in the watchlist
                            //     final isInWatchlist = watchlistCubit.isMovieInWatchlist(movie, watchlistState.movies);
                            //     return IconButton(
                            //       onPressed: () async{
                            //         final currentState = watchlistCubit.state;
                            //         // Ensure the current state is WatchlistSuccessState to access the movie list
                            //         if (currentState is WatchlistSuccessState) {
                            //           final currentWatchlist =
                            //               currentState.movies; // Extract the movie list
                            //           if (isInWatchlist) {
                            //             await watchlistCubit.removeMovieFromWatchlist(
                            //                 movie,
                            //                 currentWatchlist); // Pass the movie and the current watchlist
                            //             } else {
                            //               await watchlistCubit.addMovieToWatchlist(movie,
                            //                   currentWatchlist); // Pass the movie and the current watchlist
                            //             }
                            //           }
                            //         },
                            //         icon: Icon(
                            //           Icons.bookmark,
                            //           color: isInWatchlist ? Colors.yellow : Color.fromARGB(217, 81, 79, 79),
                            //           size: 40,
                            //         ),
                            //       );
                            //     } else if (watchlistState is WatchlistLoadingState) {
                            //       return CircularProgressIndicator(); // Show loading spinner while loading
                            //     } else {
                            //       return Icon(Icons.error); // Handle error state
                            //     }
                            //   },
                            // ),
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
                            //              child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
                            //               bloc: watchlistCubit..loadWatchlist(),
                            //   builder: (context, watchlistState) {
                            //     if (watchlistState is WatchlistSuccessState) {
                            //       final isInWatchlist = watchlistCubit.isMovieInWatchlist(movie, watchlistState.movies);
                            //       return Container(
                            //         width: 11,
                            //         height: 11,
                            //         child: Icon(
                            //           isInWatchlist ? Icons.check : Icons.add,
                            //           color: AppColors.whiteColor,
                            //         ),
                            //       );
                            //     }
                            //     return Container(); // Handle other states if needed
                            //   },
                            // ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    // Make sure the description area is also flexible
                    Flexible(
                      child: DescriptionMovieDetails(
                        classification: items,
                        overView: OverView ?? "No overview available",
                        vote: Vote,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  width: 455.62,
                  height: 220,
                  color: AppColors.blackColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(19, 15.13, 0, 0),
                          child: Text(
                            'More Like This',
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        // Pass the movieId to MoreLikeSection
                        MoreLikeSection(movieID: movieId) // Pass movieId here
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}



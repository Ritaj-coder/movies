
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_details/Movie_details.dart';

class Recomendedormorelikeitem extends StatelessWidget {
  static String baseUrl="https://image.tmdb.org/t/p/original";
  // TopRated topRated;
  // Recomendedormorelikeitem({required this.topRated});
  final Movie movie;
  Recomendedormorelikeitem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistViewModel>();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              color: Color.fromRGBO(0, 0, 0, 0.40),
              offset: Offset(0,3)
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Color(0xff343534),
      ),

      margin: EdgeInsets.fromLTRB(21, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetails.routename,
                    // arguments: movie.id, // Pass the dynamic movieId here
                    arguments: int.tryParse(movie.id) ?? -1,  // Parse String to int or pass a default value (-1)
                  );
                },
                child: CachedNetworkImage(
                  // imageUrl: '$baseUrl${topRated.posterPath ?? ''}',
                    imageUrl: '$baseUrl${movie.posterUrl}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width:96.87,
                    height: 127.74,
                    fit: BoxFit.cover
                ),
              ),
              Positioned(
                top:-15,
                left:-17,
                child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
                  bloc: watchlistCubit..loadWatchlist(),
                  builder: (context, watchlistState) {
                    if (watchlistState is WatchlistSuccessState) {
                      // Check if the movie is in the watchlist
                      final isInWatchlist = watchlistCubit.isMovieInWatchlist(movie, watchlistState.movies);
                      return IconButton(
                        onPressed: () async{
                          final currentState = watchlistCubit.state;
                          // Ensure the current state is WatchlistSuccessState to access the movie list
                          if (currentState is WatchlistSuccessState) {
                            final currentWatchlist =
                                currentState.movies; // Extract the movie list
                            if (isInWatchlist) {
                              await watchlistCubit.removeMovieFromWatchlist(
                                  movie,
                                  currentWatchlist); // Pass the movie and the current watchlist
                            } else {
                              await watchlistCubit.addMovieToWatchlist(movie,
                                  currentWatchlist); // Pass the movie and the current watchlist
                            }
                          }
                        },
                        icon: Icon(
                          Icons.bookmark,
                          color: isInWatchlist ? Colors.yellow : Color.fromARGB(217, 81, 79, 79),
                          size: 40,
                        ),
                      );
                    } else if (watchlistState is WatchlistLoadingState) {
                      return CircularProgressIndicator(); // Show loading spinner while loading
                    } else {
                      return Icon(Icons.error); // Handle error state
                    }
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: -1,
                child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
                  builder: (context, watchlistState) {
                    if (watchlistState is WatchlistSuccessState) {
                      final isInWatchlist = watchlistCubit.isMovieInWatchlist(movie, watchlistState.movies);
                      return Container(
                        width: 11,
                        height: 11,
                        child: Icon(
                          isInWatchlist ? Icons.check : Icons.add,
                          color: AppColors.whiteColor,
                        ),
                      );
                    }
                    return Container(); // Handle other states if needed
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(Icons.star,
                  color: AppColors.orangeColor,
                  size: 15,),
              ),
              Text(movie.voteAverage.toString(),
                  style:
                  TextStyle(
                      fontFamily:'inter',
                      fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: Text(movie.title.toString(),
                softWrap: true,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style:
                TextStyle(
                    fontFamily:'inter',
                    fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(movie.releaseYear,
                style:
                TextStyle(
                    fontFamily:'inter',
                    fontSize: 8,fontWeight: FontWeight.w400,color: Color(0xffB5B4B4)
                )),
          )

        ],
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_details/Movie_details.dart';

class ReleaseItem extends StatelessWidget {
  static String baseUrl = "https://image.tmdb.org/t/p/original";
  // NewRealeases newRealease;
  // int page;
  final Movie movie;
  ReleaseItem(
      {required this.movie});
  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistViewModel>();
    return Stack(
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
          child: Container(
            margin: EdgeInsets.fromLTRB(21, 10, 0, 0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: CachedNetworkImage(
                imageUrl: '$baseUrl${movie!.posterUrl ?? ''}', ///
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 96.87,
                height: 127.74,
                fit: BoxFit.cover),
            //  Image.network(newRealease.posterPath??'',
            // width:96.87,
            // height: 127.74,
            // fit: BoxFit.cover,),
          ),
        ),

        Positioned(
          top: -3,
          left: 4,
          child: Container(
            width: 27,
            height: 36,
            child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
              bloc: watchlistCubit..loadWatchlist(),
              builder: (context, watchlistState) {
                if (watchlistState is WatchlistSuccessState) {
                  // Check if the movie is already in the watchlist
                  final isInWatchlist = watchlistCubit.isMovieInWatchlist(
                      movie, watchlistState.movies);
                  return IconButton(
                    onPressed: () async {
                      // Add or remove the movie from the watchlist
                      final currentState = watchlistCubit.state;
                      // Ensure the current state is WatchlistSuccessState to access the movie list
                      if (currentState is WatchlistSuccessState) {
                        final currentWatchlist =
                            currentState.movies; // Extract the movie list

                        if (isInWatchlist) {
                          await watchlistCubit.removeMovieFromWatchlist(movie,
                              currentWatchlist); // Pass the movie and the current watchlist
                        } else {
                          await watchlistCubit.addMovieToWatchlist(movie,
                              currentWatchlist); // Pass the movie and the current watchlist
                        }
                      }
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: isInWatchlist
                          ? Colors.yellow
                          : Color.fromARGB(217, 81, 79, 79),
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
        ),

        // Icon for indicating if the movie is in watchlist
        BlocBuilder<WatchlistViewModel, WatchlistStates>(
          builder: (context, watchlistState) {
            if (watchlistState is WatchlistSuccessState) {
              final isInWatchlist = watchlistCubit.isMovieInWatchlist(
                  movie, watchlistState.movies);
              return Positioned(
                top: 12,
                left: 20,
                child: Container(
                  width: 11,
                  height: 11,
                  child: Icon(
                    isInWatchlist ? Icons.check : Icons.add,
                    color: AppColors.whiteColor,
                  ),
                ),
              );
            }
            return Container(); // Handle other states if needed
          },
        ),
      ],
    );
  }
}

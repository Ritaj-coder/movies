import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';
import '../app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/model/Response/MoreLikeThisResponse.dart';
import '../data/model/Response/MovieModel.dart';
import '../watchlist_screen/cubit/watchlist_state.dart';
import 'home_details/Movie_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MoreLikeItem extends StatelessWidget {
  static String baseUrl = "https://image.tmdb.org/t/p/original";
  final Results results;

  MoreLikeItem({required this.results});

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistViewModel>();
    int movieID = results.id as int;
    // Map Results to Movie
    Movie movie = Movie(
      id: results.id.toString(), // Convert int to String if needed
      title: results.title ?? 'Unknown Title',
      posterUrl: results.posterPath ?? '',
      releaseYear: results.releaseDate?.substring(0, 4) ?? 'Unknown',
      voteAverage: results.voteAverage ?? 0.0,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.blackColor,
      ),
      margin: EdgeInsets.fromLTRB(21, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Create a Movie object from the Results object
                    Movie movie = Movie(
                      id: results.id
                          .toString(), // Convert int to String if needed
                      title: results.title ?? 'Unknown Title',
                      posterUrl:
                      'https://image.tmdb.org/t/p/original${results.posterPath ?? ''}',
                      releaseYear:
                      results.releaseDate?.substring(0, 4) ?? 'Unknown',
                      voteAverage: results.voteAverage ?? 0.0,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movieId: movieID,
                          // movie: movie,
                        ), // Pass the movie ID
                      ),
                    );
                  },
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: '$baseUrl${results.posterPath ?? ''}',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 96.87,
                      height: 127.74,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: -17,
                  // child: Container(
                  //   width: 27,
                  //   height: 36,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.bookmark,
                  //       color: Color.fromARGB(217, 81, 79, 79),
                  //       size: 40,
                  //     ),
                  //   ),
                  // ),
                  child: BlocBuilder<WatchlistViewModel, WatchlistStates>(
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
                  // child: Container(
                  //   width: 11,
                  //   height: 11,
                  //   child: Icon(Icons.add, color: AppColors.whiteColor),
                  // ),
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.star,
                  color: AppColors.orangeColor,
                  size: 15,
                ),
              ),
              Text(
                results.voteAverage.toString(),
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              results.title.toString(),
              overflow: TextOverflow.ellipsis,
              // maxLines: 4, // Limit to 2 lines
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

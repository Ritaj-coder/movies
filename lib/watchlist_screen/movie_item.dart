

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistViewModel>();
    final currentState = watchlistCubit.state;

    // Ensure the current state is WatchlistSuccessState to access the movie list
    List<Movie> currentWatchlist = [];
    if (currentState is WatchlistSuccessState) {
      currentWatchlist = currentState.movies; // Extract the movie list
    }

    // Check if the movie is in the watchlist
    final isInWatchlist = watchlistCubit.isMovieInWatchlist(movie, currentWatchlist);

    return Card(
      color: Colors.black,
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Image.network(
          // Use the TMDb image URL logic here
          'https://image.tmdb.org/t/p/w500/${movie.posterUrl}',
          width: 100,
          height: 150,
          fit: BoxFit.cover,
        ),
        title: Text(
          movie.title!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(movie.releaseYear),
        trailing: IconButton(
          icon: Icon(
            isInWatchlist ? Icons.check : Icons.add,
            color: isInWatchlist ? Colors.green : Colors.white,
          ),
          onPressed: () async {
            if (currentState is WatchlistSuccessState) {
              // Toggle the watchlist status
              if (isInWatchlist) {
                await watchlistCubit.removeMovieFromWatchlist(movie, currentWatchlist);
              } else {
                await watchlistCubit.addMovieToWatchlist(movie, currentWatchlist);
              }
            }
          },
        ),
      ),
    );
  }
}


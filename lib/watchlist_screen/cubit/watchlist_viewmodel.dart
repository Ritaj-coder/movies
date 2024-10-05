
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/data/model/Response/SearchResponse.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';


// Define ViewModel to manage watchlist states
class WatchlistViewModel extends Cubit<WatchlistStates> {
  WatchlistViewModel() : super(WatchlistInitialState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if the movie is in the watchlist
  bool isMovieInWatchlist(Movie movie, List<Movie> currentWatchlist) {
    return currentWatchlist.any((element) => element.id == movie.id);
  }

  // Load the watchlist from Firestore
  Future<void> loadWatchlist() async {
    emit(WatchlistLoadingState());
    if (state is! WatchlistSuccessState) {
      try {
        final snapshot = await _firestore.collection('watchlist').get();

        // Map Firestore documents to Movie objects
        final movies =
        snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList();

        emit(WatchlistSuccessState(
            movies: movies)); // Emit success state with the loaded movies
      } catch (e) {
        emit(WatchlistErrorState(
            errorMessage: e.toString())); // Emit error state
      }
    }
  }

  // Add movie to the watchlist
  Future<void> addMovieToWatchlist(
      Movie movie, List<Movie> currentWatchlist) async {
    if (!isMovieInWatchlist(movie, currentWatchlist)) {
      try {
        // Add movie to Firestore
        await _firestore.collection('watchlist').add(movie.toMap());

        emit(WatchlistSuccessState(movies: [
          ...currentWatchlist,
          movie
        ])); // Emit success state with updated watchlist
      } catch (e) {
        emit(WatchlistErrorState(
            errorMessage: e.toString())); // Emit error state
      }
    }
  }

  // Remove movie from the watchlist
  Future<void> removeMovieFromWatchlist(
      Movie movie, List<Movie> currentWatchlist) async {
    try {
      final snapshot = await _firestore
          .collection('watchlist')
          .where('id', isEqualTo: movie.id)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      final updatedWatchlist =
      currentWatchlist.where((element) => element.id != movie.id).toList();
      emit(WatchlistSuccessState(
          movies:
          updatedWatchlist)); // Emit success state with updated watchlist
    } catch (e) {
      emit(WatchlistErrorState(errorMessage: e.toString())); // Emit error state
    }
  }
}
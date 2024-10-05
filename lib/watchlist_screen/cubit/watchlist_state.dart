
import 'package:movies/data/model/Response/MovieModel.dart';

abstract class WatchlistStates {}

class WatchlistInitialState extends WatchlistStates {}

class WatchlistLoadingState extends WatchlistStates {}

class WatchlistErrorState extends WatchlistStates {
  String errorMessage;
  WatchlistErrorState({required this.errorMessage});
}

class WatchlistSuccessState extends WatchlistStates {
  final List<Movie> movies;
  WatchlistSuccessState({required this.movies});
}

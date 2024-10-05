
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';
import 'package:movies/data/model/Response/SearchResponse.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchErrorState extends SearchStates {
  String errorMessage;
  SearchErrorState({required this.errorMessage});
}

class SearchSuccessState extends SearchStates {

  List<Results> results;
  SearchSuccessState({required this.results});
}

class SearchEmptyState extends SearchStates {
  final String message;

  SearchEmptyState({this.message = "No results found."});
}
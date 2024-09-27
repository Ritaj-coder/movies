

import 'package:movies/data/model/Response/SearchResponse.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchErrorState extends SearchStates {
  String errorMessage;
  SearchErrorState({required this.errorMessage});
}

class SearchSuccessState extends SearchStates {
  SearchResponse searchResponse;
  SearchSuccessState({required this.searchResponse});
}

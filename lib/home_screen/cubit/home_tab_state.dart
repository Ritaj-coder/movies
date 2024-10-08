
import 'package:movies/data/model/Response/MoreLikeThisResponse.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:movies/data/model/Response/PopularResponse.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';

abstract class HomeTabStates {}

class HomeInitialState extends HomeTabStates {}

class HomeTabNewRealeasesLoadingState extends HomeTabStates {}

class HomeTabNewRealeasesErrorState extends HomeTabStates {
  String errorMessage;
  HomeTabNewRealeasesErrorState({required this.errorMessage});
}

class HomeTabNewRealeasesSuccessState extends HomeTabStates {
  NewRealeasesResponse newRealeasesResponse;
  HomeTabNewRealeasesSuccessState({required this.newRealeasesResponse});
}

class HomeTabNTopRatedLoadingState extends HomeTabStates {}

class HomeTabTopRatedErrorState extends HomeTabStates {
  String errorMessage;
  HomeTabTopRatedErrorState({required this.errorMessage});
}
class HomeTabTopRatedSuccessState extends HomeTabStates {
  TopratedResponse topratedResponse;
  HomeTabTopRatedSuccessState({required this.topratedResponse});
}

class HomeTabMoreLikeLoadingState extends HomeTabStates {}

class HomeTabMoreLikeErrorState extends HomeTabStates {
  String errorMessage;
  HomeTabMoreLikeErrorState({required this.errorMessage});
}
class HomeTabMoreLikeSuccessState extends HomeTabStates {
  MoreLikerResponse moreLikerResponse;
  HomeTabMoreLikeSuccessState({required this.moreLikerResponse});
}
class HomeTabPopularLoadingState extends HomeTabStates {}
class HomeTabPopularErrorState extends HomeTabStates {
  String errorMessage;
  HomeTabPopularErrorState({required this.errorMessage});
}
class HomeTabPopularSuccessState extends HomeTabStates {
  PopularResponse popularResponse;
  HomeTabPopularSuccessState({required this.popularResponse});
}
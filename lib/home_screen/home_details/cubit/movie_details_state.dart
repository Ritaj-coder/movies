
import 'package:movies/data/model/Response/DetailsResponse.dart';

abstract class MovieDetailsStates{}
class MovieDetailsInitialState extends MovieDetailsStates{}
class MovieDetailsLoadingState extends MovieDetailsStates{}
class MovieDetailsErrorState extends MovieDetailsStates{
  String errorMessage;
  MovieDetailsErrorState({required this.errorMessage});
}
class MovieDetailsSuccessState extends MovieDetailsStates{
  DetailsResponse detailsResponse;
  MovieDetailsSuccessState({required this.detailsResponse});
}

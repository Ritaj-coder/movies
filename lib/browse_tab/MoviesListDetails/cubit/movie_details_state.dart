
import 'package:movies/browse_tab/MoviesListDetails/cubit/movie_details_cubit.dart';
import 'package:movies/browse_tab/cubit/browse_cubit.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';

abstract class MovieOfCategoriesState{}

class MovieOfCategoriesInitialState extends MovieOfCategoriesState{}

class  MovieOfCategoriesLaodingState extends MovieOfCategoriesState{}

class  MovieOfCategoriesSuccessState extends MovieOfCategoriesState{

  MoviesDetailsResponse moviesdetailsResponse ;
  MovieOfCategoriesSuccessState({required this.moviesdetailsResponse});
}

class  MovieOfCategoriesErrorState extends MovieOfCategoriesState{

  String failures ;
  MovieOfCategoriesErrorState({required this.failures});
}
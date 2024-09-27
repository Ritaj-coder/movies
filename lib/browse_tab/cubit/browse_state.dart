
import 'package:movies/data/failures.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';

abstract class BrowseState{}

class BrowseInitialState extends BrowseState{}

class BrowseLaodingState extends BrowseState{}

class BrowseSuccessState extends BrowseState{

 AddMoviesListResponse addMoviesListResponse ;
 BrowseSuccessState({required this.addMoviesListResponse});
}

class BrowseErrorState extends BrowseState{

  String failures ;
  BrowseErrorState({required this.failures});
}
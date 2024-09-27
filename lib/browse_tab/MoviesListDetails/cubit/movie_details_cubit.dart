
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/browse_tab/MoviesListDetails/cubit/movie_details_state.dart';
import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';

class MovieOfCategoriesViewModel extends Cubit<MovieOfCategoriesState> {

  MovieOfCategoriesViewModel():super(MovieOfCategoriesInitialState());


  List<Results> moviedetails = [];

   void getAllMovies(int genreId) async{

     try {
       emit(MovieOfCategoriesLaodingState());
      var response = await ApiManager.getAllMovies(genreId);
      if(response.success == false){
        emit(MovieOfCategoriesErrorState(failures: response.status_message!));
      }
      else {
        moviedetails = response.results ?? [] ;
       emit(MovieOfCategoriesSuccessState(moviesdetailsResponse: response));
      }
     }
     catch(e){
       emit(MovieOfCategoriesErrorState(failures: e.toString()));
     }
   }

  void filterMoviesByCategory(int genreIds) {

    final filteredMovies = moviedetails.where((movie) => movie.id == genreIds).toList();
    emit(MovieOfCategoriesSuccessState(moviesdetailsResponse: MoviesDetailsResponse(results: filteredMovies)));
  }



}
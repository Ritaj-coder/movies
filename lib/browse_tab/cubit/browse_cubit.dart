
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/browse_tab/cubit/browse_state.dart';
import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';

class MoviesViewModel extends Cubit<BrowseState>{

  MoviesViewModel():super(BrowseInitialState());

List<Genres> movieslist = [] ;

void getMoviesCategories () async{

  try {
    emit(BrowseLaodingState());
    var response = await ApiManager.getAllMoviesList();

    print('Raw API response: ${response.toJson()}');

    if(response.success == false || response.genres == null || response.genres!.isEmpty){
      print('API Error: ${response.status_message}');
      emit(BrowseErrorState(failures: response.status_message ?? "Unknown error"));
    }
    else {
      movieslist = response.genres ?? [];
      if(!isClosed) {
        emit(BrowseSuccessState(addMoviesListResponse: response));
      }
    }
  } catch (e) {
    print('Exception: $e');
    if(!isClosed) {
      emit(BrowseErrorState(failures: e.toString()));
    }
  }
}

}
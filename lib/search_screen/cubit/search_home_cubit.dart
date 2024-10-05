import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';
import 'package:movies/search_screen/cubit/search_home_state.dart';

class SearchViewModel extends Cubit<SearchStates> {
  SearchViewModel() : super(SearchInitialState());
  //todo: hold data - handle logic
  List<Movie>? moviesList;

  void search(String query) async {
    try {
      emit(SearchLoadingState());
      var response = await ApiManager.search(query); // Ensure this returns a proper response
      if (response.success == false) {
        emit(SearchErrorState(errorMessage: response.status_message ?? "Unknown Error"));
      } else {
        // Cast the List<dynamic> to List<Results>
        List<Results> results = (response.results as List)
            .map((item) => Results.fromJson(item as Map<String, dynamic>))
            .toList();

        emit(SearchSuccessState(results: results)); // Use the casted List<Results>
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }




}


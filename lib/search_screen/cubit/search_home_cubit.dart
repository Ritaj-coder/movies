
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/search_screen/cubit/search_home_state.dart';

class SearchViewModel extends Cubit<SearchStates> {
  SearchViewModel() : super(SearchInitialState());
  //todo: hold data - handle logic
  List<Movie>? moviesList;

  // void search(String title) async {
  //   try {
  //     emit(SearchLoadingState()); ////
  //     var response = await ApiManager.search(title);
  //     if (response.success == 'false') {
  //       emit(SearchErrorState(errorMessage: response.status_message!));
  //     } else {
  //       // moviesList = response.results ?? [];
  //       emit(SearchSuccessState(searchResponse: response));
  //     }
  //   } catch (e) {
  //     emit(SearchErrorState(errorMessage: e.toString()));
  //   }
  // }

  void search(String query) async {
    try {
      emit(SearchLoadingState()); ////
      var response = await ApiManager.search(query);
      if (response.success == 'false') {
        emit(SearchErrorState(errorMessage: response.status_message!));
      } else {
        // moviesList = response.results ?? [];
        // Assuming `response.results` is List<dynamic> and `Movie.fromJson` is your method to parse a JSON object to a `Movie`
        moviesList = response.results?.map<Movie>((json) => Movie.fromJson(json)).toList();
        emit(SearchSuccessState(searchResponse: response));
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
//////////////

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie/data/model/response/SearchResponse.dart';
// import 'package:movie/Search/cubit/search_states.dart';
// import 'package:movie/Search/movie_model.dart';
// import 'package:movie/data/api_manager.dart';

// class SearchViewModel extends Cubit<SearchStates> {
//   SearchViewModel() : super(SearchInitialState());

//   // List<Movie> moviesList = [];

//   Future<void> search(String query) async {
//     try {
//           emit(SearchLoadingState());
//       SearchResponse searchResponse = await ApiManager.search(query);
//       // moviesList = searchResponse.results!.map((movieData) => Movie.fromJson(movieData)).toList();
//             // moviesList = searchResponse.results?.map<Movie>((json) => Movie.fromJson(json)).toList();
//       emit(SearchSuccessState(searchResponse: searchResponse));
//     } catch (e) {
//       emit(SearchErrorState(errorMessage: e.toString()));
//     }
//   }
// }

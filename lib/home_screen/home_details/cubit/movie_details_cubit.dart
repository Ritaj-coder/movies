
import 'package:movies/data/api_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/DetailsResponse.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_state.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates>{
  MovieDetailsViewModel():super(MovieDetailsInitialState());
  List<DetailsResponse>? detailsList ;
  List<Genres>? genres ;
  String? title ;
  var year ;
  int? hours ;
  int? minutes ;
  String? overview;
  num? vote ;
  String? poster_image;
  String? backdrop_path;
  void getMovieDetails() async {
    try{
      emit(MovieDetailsLoadingState());
      var response = await ApiManager.getMovieDetails();
      if (response.success == 'false'){
        emit(MovieDetailsErrorState(errorMessage: response.status_message!));
        return;
      }
      else {
        title = response.originalTitle;
        overview = response.overview;
        vote = response.voteAverage;
        genres = response.genres;
        poster_image = response.posterPath;
        backdrop_path = response.backdropPath;
        if (response.releaseDate != null && response.releaseDate!.isNotEmpty) {
          DateTime releaseDate = DateTime.parse(response.releaseDate!);
          year = releaseDate.year;
        }
        if (response.runtime != null) {
          int totalMinutes = response.runtime!.toInt();  // Ensure runtime is treated as an int
          hours = totalMinutes ~/ 60;  // Integer division for hours
          minutes = totalMinutes % 60; // Remainder for minutes
        }
        genres = response.genres ?? [];
        detailsList?.add(response) ;
        emit(MovieDetailsSuccessState(detailsResponse: response));
      }
    }catch(e){
      print(e.toString());
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }

}

import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/MoreLikeThisResponse.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/PopularResponse.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabStates> {
  HomeTabCubit() : super(HomeInitialState());
  static const String baseUrl = "https://image.tmdb.org/t/p/original";
  List<NewRealeases> newRealeasesList = [];
  List<TopRated> topRatedList = [];
  int currentPage = 1; // Start from page 1
  List<Results> moreLikeList = [];
  List <Popular> popularList=[];
  List<String> imageUrls = [];
  List<String> titles = [];
  List<String>dates=[];

  Future<void> getAllNewRealeases() async {
    try {
      emit(HomeTabNewRealeasesLoadingState());
      var response = await ApiManager.getAllNewRealeases(page: currentPage.toString());

      if (response.success == false) {
        emit(HomeTabNewRealeasesErrorState(errorMessage: response.statusMessage!));
      } else {
        newRealeasesList.addAll(response.results ?? []);
        emit(HomeTabNewRealeasesSuccessState(newRealeasesResponse: response));
        currentPage++;

      }
    } catch (e) {
      emit(HomeTabNewRealeasesErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> getAllTopRated() async {
    try {
      emit(HomeTabNTopRatedLoadingState());
      var response = await ApiManager.getAllTopRated(page: currentPage.toString());

      if (response.success == false) {
        emit(HomeTabTopRatedErrorState(errorMessage: response.statusMessage!));
      } else {
        topRatedList.addAll(response.results ?? []);
        emit(HomeTabTopRatedSuccessState(topratedResponse: response));
        currentPage++;

      }
    } catch (e) {
      emit(HomeTabTopRatedErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> getPopulars() async {
    try {
      emit(HomeTabPopularLoadingState());
      var response = await ApiManager.getPopulars();

      if (response.success == false) {
        emit(HomeTabPopularErrorState(errorMessage: response.statusMessage!));
      } else {
        popularList.addAll(response.results ?? []);
        imageUrls = popularList
            .map((popular) => baseUrl + (popular.backdropPath ?? ''))
            .toList();
        titles = popularList
            .map((popular) =>(popular.title ?? ''))
            .toList();
        dates = popularList
            .map((popular) =>(popular.releaseDate ?? ''))
       .toList();
        emit(HomeTabPopularSuccessState(popularResponse: response));
      }
    } catch (e) {
      emit(HomeTabPopularErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> getAllMoreLike(int movieID) async {
    emit(HomeTabMoreLikeLoadingState());
    try {
      MoreLikerResponse response = await ApiManager.getAllMoreLike(movieID: movieID, page: currentPage.toString());
      if (response.success == false) {
        emit(HomeTabMoreLikeErrorState(errorMessage: response.statusMessage!));
        return;
      } else {
        moreLikeList = response.results ?? [];
        emit(HomeTabMoreLikeSuccessState(moreLikerResponse: response));
        currentPage++;
      }
    } catch (e) {
      emit(HomeTabMoreLikeErrorState(errorMessage: e.toString()));
    }
  }
  Movie getTopRatedMovie() {
    if (topRatedList.isNotEmpty) {
      TopRated topRatedMovie = topRatedList[0]; // Get a TopRated movie
      return Movie(
          id: topRatedMovie.id.toString(),
          title: topRatedMovie.title!,
          posterUrl:
          topRatedMovie.posterPath!, // Adjust field names accordingly
          releaseYear: topRatedMovie.releaseDate?.substring(0, 4) ?? 'Unknown',
          voteAverage: topRatedMovie.voteAverage!.toDouble());
    }
    throw Exception("No top-rated movies available");
  }
  Movie getNewReleaseMovie() {
    if (newRealeasesList.isNotEmpty) {
      NewRealeases newRealeaseMovie =
      newRealeasesList[0]; // Get a newrealease movie
      return Movie(
          id: newRealeaseMovie.id.toString(),
          title: newRealeaseMovie.title!,
          posterUrl:
          newRealeaseMovie.posterPath!, // Adjust field names accordingly
          releaseYear:
          newRealeaseMovie.releaseDate?.substring(0, 4) ?? 'Unknown',
          voteAverage: newRealeaseMovie.voteAverage!.toDouble());
    }
    throw Exception("No new-realease movies available");
  }
}

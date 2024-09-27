
import 'package:movies/data/api_data.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabStates> {
  HomeTabCubit() : super(HomeInitialState());

  List<NewRealeases> newRealeasesList = [];
  List<TopRated> topRatedList = [];
  int currentPage = 1; // Start from page 1

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
}

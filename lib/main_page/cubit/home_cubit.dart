
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/browse_tab/browse_tab.dart';
import 'package:movies/home_screen/home_screen.dart';
import 'package:movies/main_page/cubit/home_state.dart';
import 'package:movies/search_screen/search_screen.dart';
import 'package:movies/watchlist_screen/watchlist_screen.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates>{

  HomeScreenViewModel() : super(HomeInitialState());

  ///todo: hold data - handle logic
  int selectedindex = 0;

  List<Widget> tabs = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchlistScreen()
  ];

  void changeSelectedIndex(int newindex){
    emit(HomeInitialState());
    selectedindex = newindex ;
    emit(ChangeSelectedIndexState());
  }
}
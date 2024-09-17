
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/main_page/cubit/home_cubit.dart';
import 'package:movies/main_page/cubit/home_state.dart';

class MainPage extends StatefulWidget {
  static const String routename = 'main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeScreenViewModel,HomeScreenStates>(
      bloc: viewModel,
      builder: ( context, state) {
     return Scaffold(
       bottomNavigationBar: BottomAppBar(
         shape: CircularNotchedRectangle(),
         notchMargin: 8,
         child: BottomNavigationBar(
           currentIndex: viewModel.selectedindex,
           onTap: (index){
             viewModel.changeSelectedIndex(index);
           },
           type: BottomNavigationBarType.fixed,
           backgroundColor: AppColors.greyColor,
           selectedItemColor: AppColors.orangeColor,
           unselectedItemColor: AppColors.whiteColor,
           items: [
             BottomNavigationBarItem(
                 label: "HOME",
                 icon: Icon(Icons.home,size: 30,)
             ),
             BottomNavigationBarItem(
                 label: "SEARCH",
                 icon: Icon(Icons.search,size: 30,)
             ),
             BottomNavigationBarItem(
                 label: "BROWSE",
                 icon: Icon(Icons.movie_creation,size: 30,)
             ),
             BottomNavigationBarItem(
                 label: "WATCHLIST",
                 icon: Icon(Icons.list_alt_sharp,size: 30,)
             ),
           ],
         ),
       ),
       body: viewModel.tabs[viewModel.selectedindex],

     );
      },

    );
  }
}

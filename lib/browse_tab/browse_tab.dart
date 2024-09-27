import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/browse_tab/MoviesListDetails/browse_details.dart';
import 'package:movies/browse_tab/browse_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/browse_tab/cubit/browse_cubit.dart';
import 'package:movies/browse_tab/cubit/browse_state.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';

class BrowseScreen extends StatelessWidget {

MoviesViewModel viewModel = MoviesViewModel();

final List<String> imagepaths = [
  "assets/images/code28.jpg","assets/images/code12.jpg",
  "assets/images/code16.jpg" , "assets/images/code35.jpg",
  "assets/images/code80.jpg","assets/images/code99.jpg",
  "assets/images/code18.jpg", "assets/images/code10751.jpg",
  "assets/images/code14.jpg","assets/images/code36.jpg",
  "assets/images/code27.jpg","assets/images/code10402.jpg",
  "assets/images/code9648.jpg", "assets/images/code18.jpg",
  "assets/images/code878.jpg","assets/images/code10770.jpg",
  "assets/images/code53.jpg","assets/images/code10752.jpg","assets/images/code37.jpg"
];

  @override
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (context)=> MoviesViewModel()..getMoviesCategories(),
          child: BlocBuilder<MoviesViewModel,BrowseState>(
            builder: (context,state){
              return Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Text("Browse Category",style: Theme.of(context).textTheme.bodyLarge
                    !.copyWith(fontSize: 25),),
                    SizedBox(height: 10,),

                    state is BrowseSuccessState ?
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        child: GridView.builder(
                            itemCount:state.addMoviesListResponse.genres!.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 16
                            ),
                            itemBuilder: (context,index){
                              String imagePath = imagepaths[index % imagepaths.length];
                              return BrowseItem(movie: state.addMoviesListResponse.genres![index],
                           imagepath: imagePath,);
                            }
                        ),
                      ),
                      ) :
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
  }
}
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';
import 'package:movies/home_screen/new_release_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/home_screen/recommendedormorelikesection.dart';

class HomeScreen extends StatelessWidget {

  HomeTabCubit cubit=HomeTabCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabCubit,HomeTabStates>(
      bloc: cubit..getAllTopRated(),
      builder: (context,state){
        return Scaffold(
          body : Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 28),
                    child: Image.asset('assets/images/home1.png',
                      width: 412,
                      height: 217,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(176, 107, 0, 0),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.whiteColor
                    ),
                    child: IconButton(
                      padding: EdgeInsets.all(5),
                      iconSize: 50,
                      icon: const Icon(
                        color: Color.fromARGB(88, 15, 15, 15),
                        Icons.play_arrow,
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                  Positioned(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(21, 118, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.asset(
                                'assets/images/home2.png',
                                width: 129,
                                height: 199,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 105,
                              left: 4,
                              child: Container(
                                width: 27,
                                height: 36,
                                child: IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Color.fromARGB(217, 81, 79, 79),
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 20,
                              child: Container(
                                  width: 11,
                                  height: 11,
                                  child:  InkWell(
                                    onTap: (){
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded( // Use Expanded here to take available space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 235),
                                child: Text(
                                  'Dora and the lost city of gold',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        '2019  PG-13  2h 7m',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffB5B4B4),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: (){},
                                        child: Icon(
                                          Icons.question_mark,
                                          color: AppColors.whiteColor,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        width:455.62 ,
                        color: AppColors.greyColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(19, 15.13, 0, 0),
                              child: Text('New Releases ',
                                  style:
                                  TextStyle(
                                      fontFamily:'inter',
                                      fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                                  )),),
                            state is HomeTabNewRealeasesLoadingState?
                            const Center(child: CircularProgressIndicator(
                                color: AppColors.orangeColor)):
                            Newreleasessection(),
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              width:455.62 ,
                              color: AppColors.greyColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(19, 15.13, 0, 0),
                                    child: Text('Recomended ',
                                        style:
                                        TextStyle(
                                            fontFamily:'inter',
                                            fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                                        )),),
                                  state is HomeTabNTopRatedLoadingState?
                                  const  Center(child: CircularProgressIndicator(
                                    color: AppColors.orangeColor,
                                  ),)
                                      :Recomendedormorelikesection()

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}

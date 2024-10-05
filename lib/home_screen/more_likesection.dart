
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/home_screen/more_likeitem.dart';
import 'cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MoreLikeSection extends StatefulWidget {
  final int movieID;
  MoreLikeSection({required this.movieID});

  @override
  State<MoreLikeSection> createState() => _MoreLikeSectionState(movieID);
}

class _MoreLikeSectionState extends State<MoreLikeSection> {
  final int movieID; // Store movieID
  HomeTabCubit cubit = HomeTabCubit();
  final ScrollController _scrollController = ScrollController();

  // Constructor to accept movieID
  _MoreLikeSectionState(this.movieID);

  @override
  void initState() {
    super.initState();
    context.read<HomeTabCubit>().getAllMoreLike(movieID);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<HomeTabCubit>().getAllMoreLike(movieID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<HomeTabCubit, HomeTabStates>(
        bloc: cubit..getAllMoreLike(movieID), // Pass movieID
        builder: (context, state) {
          if (state is HomeTabMoreLikeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeTabMoreLikeErrorState) {
            return Center(child: Text(state.errorMessage, style: TextStyle(color: AppColors.whiteColor)));
          } else if (state is HomeTabMoreLikeSuccessState) {
            final moreLikeList = context.read<HomeTabCubit>().moreLikeList;
            print("Fetched list length: ${moreLikeList?.length}");
            if (moreLikeList.isEmpty) {
              return Center(child: Text('No releases available', style: TextStyle(color: AppColors.whiteColor)));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: moreLikeList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MoreLikeItem(results: moreLikeList[index]);
              },
            );
          }
          return Center(child: Text('No releases available'));
        },
      ),
    );
  }
}


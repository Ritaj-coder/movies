
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';
import 'package:movies/home_screen/recommended_ormorelikeitem.dart';

import '../app_colors.dart';

class Recomendedormorelikesection extends StatefulWidget {
  const Recomendedormorelikesection({super.key});

  @override
  State<Recomendedormorelikesection> createState() => _RecomendedormorelikesectionState();
}

class _RecomendedormorelikesectionState extends State<Recomendedormorelikesection> {
  final ScrollController _scrollController = ScrollController();
  HomeTabCubit cubit = HomeTabCubit();
  @override
  void initState() {
    super.initState();
    context.read<HomeTabCubit>().getAllTopRated();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<HomeTabCubit>().getAllTopRated();
      }
    });
  }
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child:BlocBuilder<HomeTabCubit, HomeTabStates>(
        bloc: cubit..getAllTopRated(),
        builder: (context, state) {
          if (state is HomeTabNTopRatedLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is HomeTabTopRatedErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          else if (state is HomeTabTopRatedSuccessState) {
            final newTopRatedList = context.read<HomeTabCubit>().topRatedList;
            print("Fetched list length: ${newTopRatedList?.length}");
            if (newTopRatedList!.isEmpty) {
              return Center(child: Text('No releases available',style: TextStyle(color: AppColors.whiteColor),));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: newTopRatedList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // return Recomendedormorelikeitem(topRated: newTopRatedList[index],);
                final topRated = newTopRatedList[index];
                final movie = Movie(
                  id: newTopRatedList[index].id.toString(),
                  title: topRated.title!,
                  posterUrl:
                  'https://image.tmdb.org/t/p/w500${topRated.posterPath}',
                  releaseYear: topRated.releaseDate!.substring(0, 4),
                  // actors: newRelease.actors, // Assuming actors are part of NewRealeases
                  // movieType: newRelease. ?? 'Unknown', // Assuming genre is available
                  voteAverage:
                  topRated.voteAverage ?? 0.0, // Provide default if null
                );
                return Recomendedormorelikeitem(movie: movie);
              },
            );
          }
          return Center(child: Text('No releases available'));
        },
      ),
    );
  }
}
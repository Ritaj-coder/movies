import 'package:flutter/material.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';
import 'package:movies/home_screen/release_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/Response/New_ReleaseResponse.dart';

class Newreleasessection extends StatefulWidget {
  @override
  _NewreleasessectionState createState() => _NewreleasessectionState();
}

class _NewreleasessectionState extends State<Newreleasessection> {
  HomeTabCubit cubit = HomeTabCubit();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HomeTabCubit>().getAllNewRealeases();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<HomeTabCubit>().getAllNewRealeases();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<HomeTabCubit, HomeTabStates>(
        bloc: cubit..getAllNewRealeases(),
        builder: (context, state) {
          if (state is HomeTabNewRealeasesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeTabNewRealeasesErrorState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is HomeTabNewRealeasesSuccessState) {
            final newRealeasesList =
                context.read<HomeTabCubit>().newRealeasesList;
            if (newRealeasesList.isEmpty) {
              return Center(child: Text('No releases available'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: newRealeasesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // return Releaseitem(newRealease: newRealeasesList[index],page: newRealeasesList[index].id!,);
                final newRelease = newRealeasesList[index];
                final movie = Movie(
                  id: newRealeasesList[index].id.toString(),
                  title: newRelease.title!,
                  posterUrl:
                  'https://image.tmdb.org/t/p/w500${newRelease.posterPath}',
                  releaseYear: newRelease.releaseDate!.substring(0, 4),
                  // actors: newRelease.actors, // Assuming actors are part of NewRealeases
                  // movieType: newRelease. ?? 'Unknown', // Assuming genre is available
                  voteAverage:
                  newRelease.voteAverage ?? 0.0, // Provide default if null
                );
                return ReleaseItem(
                  movie: movie,
                  // newRealease: NewRealeases(),
                );
              },
            );
          }
          return Center(child: Text('No releases available'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

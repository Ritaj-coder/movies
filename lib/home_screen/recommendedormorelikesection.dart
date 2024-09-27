
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';
import 'package:movies/home_screen/recommended_ormorelikeitem.dart';

class Recomendedormorelikesection extends StatefulWidget {
  const Recomendedormorelikesection({super.key});

  @override
  State<Recomendedormorelikesection> createState() => _RecomendedormorelikesectionState();
}

class _RecomendedormorelikesectionState extends State<Recomendedormorelikesection> {
  final ScrollController _scrollController = ScrollController();
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
        builder: (context, state) {
          if (state is HomeTabNTopRatedLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeTabTopRatedErrorState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is HomeTabTopRatedSuccessState) {
            final newTopRatedList = context.read<HomeTabCubit>().topRatedList;

            return ListView.builder(
              controller: _scrollController,
              itemCount: newTopRatedList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Recomendedormorelikeitem(topRated: newTopRatedList[index],);
              },
            );
          }
          return Center(child: Text('No releases available'));
        },
      ),
    );
  }
}
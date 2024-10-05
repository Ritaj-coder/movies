
import 'package:flutter/material.dart';
import 'package:movies/home_screen/cubit/home_tab_cubit.dart';
import 'package:movies/home_screen/cubit/home_tab_state.dart';
import 'package:movies/home_screen/release_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newreleasessection extends StatefulWidget {
  @override
  _NewreleasessectionState createState() => _NewreleasessectionState();
}
class _NewreleasessectionState extends State<Newreleasessection> {

  HomeTabCubit cubit=HomeTabCubit();

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
          }
          else if (state is HomeTabNewRealeasesErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          else if (state is HomeTabNewRealeasesSuccessState) {
            final newRealeasesList = context.read<HomeTabCubit>().newRealeasesList;
            if (newRealeasesList.isEmpty) {
              return Center(child: Text('No releases available'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: newRealeasesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Releaseitem(newRealease: newRealeasesList[index],page: newRealeasesList[index].id!,);
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
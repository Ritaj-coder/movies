import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_state.dart';
import 'package:movies/search_screen/cubit/search_home_cubit.dart';
import 'package:movies/search_screen/cubit/search_home_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  SearchViewModel viewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchViewModel>(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            elevation: 0,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.searchbackColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            print(
                                'Search Query: $value'); // Ensure the query is captured
                            viewModel
                                .search(value); // Trigger search based on input
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search Movies",
                          hintStyle: TextStyle(
                            fontFamily: 'inter',
                            color: AppColors.whiteColor,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<SearchViewModel, SearchStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchErrorState) {
                return Center(
                  child: Text(
                    'Error: ${state.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is SearchSuccessState) {
                // var movies = state.searchResponse.results ?? [];
                var movies = state.results;

                if (movies.isEmpty) {
                  return _buildNoResultsView();
                }
                return _buildMovieList(movies);
              } else {
                return _buildNoResultsView();
              }
            },
          ),
//           body: BlocBuilder<SearchViewModel, SearchStates>(
//   builder: (context, state) {
//     if (state is SearchLoadingState) {
//       return CircularProgressIndicator();
//     } else if (state is SearchSuccessState) {
//       return ListView.builder(
//         itemCount: state.searchResponse.results?.length ?? 0,
//         itemBuilder: (context, index) {
//           var movie = state.searchResponse.results![index];
//           return ListTile(
//             title: Text(movie.title),
//             subtitle: Text(movie.releaseDate),
//           );
//         },
//       );
//     } else if (state is SearchEmptyState) {
//       return Center(
//         child: Text(state.message), // Show the empty state message
//       );
//     } else if (state is SearchErrorState) {
//       return Center(
//         child: Text('Error: ${state.errorMessage}'),
//       );
//     }
//     return Container(); // Default case
//   },
// ),
        ),
      ),
    );
  }

  Widget _buildMovieList(List<Results> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath ?? ""}',
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          title: Text(
            movie.title ?? "No Title",
            style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${movie.releaseDate ?? "No Date"}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15, color: AppColors.searchbackColor),
              ),
              // Text(
              //   movie.actors != null ? movie.actors.join(', ') : "No Actors",
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyLarge!
              //       .copyWith(fontSize: 15, color: AppColors.whiteColor),
              // ),
              Row(
                children: [
                  Text(
                    "Vote Avg: ${movie.voteAverage}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 15, color: AppColors.whiteColor),
                    maxLines: 2,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                ],
              )
            ],
          ),
          onTap: () {
            // Handle movie selection
          },
        );
      },
    );
  }

  Widget _buildNoResultsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset("assets/images/iconmovie.png"),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "No Movies Found",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: 'inter',
          ),
        ),
      ],
    );
  }
}

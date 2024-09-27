import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<Movie> movies = Movie.allMovies;
  // List<Map<String, dynamic>> searchresult = [];
  // List<Movie> searchresult = [];

  // bool hasSearched = false; // Flag to track if search has been performed
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  final TextEditingController _controller = TextEditingController();

  // void searchMovie(String newQuery) {
  //   if (newQuery.isEmpty) {
  //     setState(() {
  //       // hasSearched = false; // Reset search flag if query is empty
  //       // movies = Movie.allMovies; // Show all movies or initial state
  //       Center(child: Text('NO Data'));
  //     });
  //   } else {
  //     final suggestions = Movie.allMovies.where((movie) {
  //       final movieTitle = movie.title.toLowerCase();
  //       final input = newQuery.toLowerCase();
  //       return movieTitle.contains(input);
  //     }).toList();
  //     setState(() {
  //       // hasSearched = true; // Set search flag true as search has been performed
  //       searchresult = suggestions;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsViewModel>(
      create: (context) => MovieDetailsViewModel()..getMovieDetails(),
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
                      borderRadius: BorderRadius.circular(25)),
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
                            // onChanged: (value) => viewModel.,
                            decoration: InputDecoration(
                                hintText: "Search Movies",
                                hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    color: AppColors.whiteColor),
                                border: InputBorder.none),
                            style: TextStyle(color: AppColors.whiteColor),
                          ))
                    ],
                  ),
                ),
              )),
          body:
          // movies.isEmpty || !hasSearched
          //     ?
          // Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Center(
          //             child: Image.asset("assets/iconmovie.jpg"),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Text(
          //             "No Movies Found",
          //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //                   fontFamily: 'inter',
          //                 ),
          //           )
          //         ],
          //       )
          // :
          BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is MovieDetailsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieDetailsErrorState) {
                print(state.errorMessage);
                return Text('Error: ${state.errorMessage}');
              } else if (state is MovieDetailsSuccessState) {
                var movies = viewModel.detailsList!;
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return ListTile(
                            leading: Image.network(
                              'https://image.tmdb.org/t/p/w500${viewModel.poster_image}',
                              // movie.posterUrl,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                            title: Text(
                              // movie.title,
                              viewModel.title??'',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 18),
                            ),
                            subtitle: Text(
                                '${viewModel.year}'
                                // -
                                // ${movie.actors.join(', ')}'
                                ,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    fontSize: 15,
                                    color: AppColors.searchbackColor)),
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, Detailspage.routeName,
                              //     arguments: movie);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
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
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:movie/app_colors.dart';

// class Movie {
//   final String title;
//   final String posterUrl;
//   final String releaseYear;
//   final List<String> actors;

//   Movie(this.title, this.posterUrl, this.releaseYear, this.actors);
// }

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   List<Movie> allMovies = [
//     Movie('Alita: Battle Angel', 'assets/image4.png', '2019',
//         ['Rosa Salazar', 'Christoph Waltz']),
//     Movie('Inception', 'assets/image4.png', '2010',
//         ['Leonardo DiCaprio', 'Ellen Page']),
//     // Add more movies here
//   ];
//   List<Movie> filteredMovies = [];

//   @override
//   void initState() {
//     super.initState();
//     // filteredMovies = allMovies;
//     filteredMovies = List<Movie>.from(allMovies);
//   }

//   void _searchMovies(String query) {
//     List<Movie> results = allMovies
//         .where(
//             (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     // allMovies.forEach((movie) {
//     //   if (movie.title.toLowerCase().contains(query.toLowerCase()))
//     //     filteredMovies.add(movie);
//     // });
//     setState(() {
//       filteredMovies = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.blackColor,
//         elevation: 0,
//         title: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20),
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: AppColors.searchbackColor,
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Icon(Icons.search, color: AppColors.whiteColor),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search",
//                       hintStyle: TextStyle(
//                           fontFamily: 'inter', color: AppColors.whiteColor),
//                       border: InputBorder.none,
//                     ),
//                     style: TextStyle(color: AppColors.whiteColor),
//                     onChanged: _searchMovies,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: filteredMovies.length,
//         itemBuilder: (context, index) {
//           final movie = filteredMovies[index];
//           return ListTile(
//             // leading: Image.asset(movie.posterUrl),
//             leading: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(movie.posterUrl),
//                 ),
//               ),
//               // child: Image.asset(
//               //   movie.posterUrl,
//               // ),
//             ),
//             title: Text(
//               movie.title,
//               style:
//                   Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
//             ),
//             subtitle: Text('${movie.releaseYear} - ${movie.actors.join(', ')}',
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyLarge!
//                     .copyWith(fontSize: 15, color: AppColors.searchbackColor)),
//           );
//         },
//       ),
//     );
//   }
// }

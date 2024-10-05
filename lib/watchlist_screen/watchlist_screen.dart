import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_state.dart';
import 'package:movies/watchlist_screen/cubit/watchlist_viewmodel.dart';


class WatchlistScreen extends StatefulWidget {
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistViewModel>().loadWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchlistViewModel>(
      create: (context) => WatchlistViewModel()..loadWatchlist(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.black,
          ),
          body: BlocBuilder<WatchlistViewModel, WatchlistStates>(
            builder: (context, state) {
              if (state is WatchlistLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WatchlistSuccessState) {
                final watchlist = state.movies;
                if (watchlist.isEmpty) {
                  return _buildEmptyWatchlist();
                } else {
                  return ListView.builder(
                    itemCount: watchlist.length,
                    itemBuilder: (context, index) {
                      final movie = watchlist[index];
                      final watchlistCubit = context.read<WatchlistViewModel>();
                      final isInWatchlist =
                      watchlistCubit.isMovieInWatchlist(movie, watchlist);

                      return Card(
                        color: Colors.black,
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie.posterUrl}',
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${movie.releaseYear}'),
                          trailing: IconButton(
                            icon: Icon(
                              isInWatchlist ? Icons.delete : Icons.add,
                              color:
                              isInWatchlist ? Colors.red : Colors.white,
                            ),
                            onPressed: () async {
                              // Get the current state
                              final currentState = watchlistCubit.state;

                              // Ensure the current state is WatchlistSuccessState to access the movie list
                              if (currentState is WatchlistSuccessState) {
                                final currentWatchlist = currentState
                                    .movies; // Extract the movie list

                                if (isInWatchlist) {
                                  await watchlistCubit.removeMovieFromWatchlist(
                                      movie,
                                      currentWatchlist); // Pass the movie and the current watchlist
                                } else {
                                  await watchlistCubit.addMovieToWatchlist(
                                      movie,
                                      currentWatchlist); // Pass the movie and the current watchlist
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (state is WatchlistErrorState) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else {
                return Container(); // Empty state
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyWatchlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/iconmovie.png"),
          SizedBox(height: 10),
          Text(
            "No Movies Added",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/MovieModel.dart';
import 'package:movies/home_screen/home_details/cubit/movie_details_cubit.dart';
import 'package:movies/watchlist_screen/watchlist_data.dart';

class WatchlistScreen extends StatefulWidget {
  List<Movie> movie = [];

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  var watchlistData = WatchlistData.watchList;
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
          Text('Watchlist', style: TextStyle(color: AppColors.whiteColor)),
          backgroundColor: AppColors.blackColor,
        ),
        body: watchlistData.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/images/iconmovie.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "No Movies Added",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: 'inter',
              ),
            )
          ],
        )
            : ListView.builder(
          itemCount: WatchlistData.watchlist.length,
          itemBuilder: (context, index) {
            // final movie = Movie.allMovies[index];
            return Card(
              color: AppColors.blackColor,
              elevation: 5,
              margin: EdgeInsets.all(8),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    viewModel.poster_image!,
                    // movie.posterUrl,
                    width: 120,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  // movie.title,
                  viewModel.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${viewModel.year} ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    WatchlistData.remove(watchlistData[index]);
                    setState(() {});
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

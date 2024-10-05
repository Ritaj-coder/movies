
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/data/model/Response/MovieModel.dart';

class WatchlistRepository {
  final CollectionReference watchlistCollection =
  FirebaseFirestore.instance.collection('watchlists');

  Future<void> addMovieToWatchlist(Movie movie) async {
    await watchlistCollection.add({
      'id':movie.id,
      'title': movie.title,
      'posterUrl': movie.posterUrl,
      'releaseYear': movie.releaseYear,
      'actors':movie.actors,
      // 'movieType':movie.movieType,
      'voteAverage':movie.voteAverage
    });
  }

  Future<void> removeMovieFromWatchlist(Movie movie) async {
    final snapshot = await watchlistCollection
        .where('title', isEqualTo: movie.title)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<Movie>> getWatchlist() async {
    final snapshot = await watchlistCollection.get();
    return snapshot.docs.map((doc) {
      return Movie(
          id: doc['id'],
          title: doc['title'],
          posterUrl: doc['posterUrl'],
          releaseYear: doc['releaseYear'],
          actors: doc['actors'],
          // movieType: doc['movieType'],
          voteAverage: doc['voteAverage']
      );
    }).toList();
  }
}

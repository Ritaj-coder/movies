class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String releaseYear;
  final List<String>? actors;
  final num voteAverage;


  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.releaseYear,
    this.actors,
    required this.voteAverage,
    // required this.movieType,
  });



  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      releaseYear: json['release_date'].substring(0, 4),
      actors: List<String>.from(json['actors'] ?? []), // Provide default if null
      // movieType: json['genre'] ?? 'Unknown', // Assuming genre is the movieType
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),  // Provide default if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
      'voteAverage': voteAverage,
      'releaseYear': releaseYear,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      posterUrl: map['posterUrl'],
      voteAverage: map['voteAverage'],
      releaseYear: map['releaseYear'],
    );
  }

}

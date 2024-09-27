
class Movie {
  final String title;
  final String posterUrl;
  final String releaseYear;
  final List<String> actors;
  Movie(
      {required this.title,
        required this.posterUrl,
        required this.releaseYear,
        required this.actors});

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     title: json['title'],
  //     posterUrl: json['posterUrl'],
  //     releaseYear: json['releaseYear'],
  //     actors: List<String>.from(json['actors']),
  //   );
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        releaseYear: json['release_date'].substring(0, 4),
        actors: List<String>.from(json['actors'])
    );
  }


}
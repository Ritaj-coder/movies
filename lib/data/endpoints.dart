
class EndPoints {
  static const String movieslist = "/3/genre/movie/list" ;
  static const String moviesdetails = "/3/discover/movie" ;
  static const String newRealeases = '/3/movie/upcoming';
  static const String topRated = '/3/movie/top_rated';
  static const String search = '/3/search/movie';
  late int movieId ;
  static String movieDetails(int movieId) {
    return '/3/movie/$movieId?api_key=YOUR_API_KEY&language=en-US';
  }
  late int movieID ;
  static String moreLike(int movieID) {
    return '/3/movie/$movieID/similar';
    }
  static const String popular='/3/movie/popular';
  }
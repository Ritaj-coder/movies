import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/data/api_name.dart';
import 'package:movies/data/endpoints.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';
import 'package:movies/data/model/Response/MoviesDetailsResponse.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';

class ApiManager {

  static Future<NewRealeasesResponse> getAllNewRealeases({required String page}) async {
    Uri url = Uri.https(ApiName.baseURL,EndPoints.newRealeases);

    Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQ2NmVkYjViMDYzNWQ1ZDBkNzAwNjI2OGNhOGM2YyIsIm5iZiI6MTcyNjYwMzg4Mi40ODkxNzIsInN1YiI6IjY2ZTlkODg0NWMwNTE5YTIzNGQzMGE0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qHGfuhfJaExeUxfqzB_QnUphv0NFJoHE_dQ6Jof_Rwo',
      'Accept': 'application/json',
    };
    try {
      var response = await http.get(url,headers:headers );
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewRealeasesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }


  static Future<TopratedResponse> getAllTopRated({required String page}) async {
    Uri url = Uri.https(ApiName.baseURL,EndPoints.topRated);

    Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQ2NmVkYjViMDYzNWQ1ZDBkNzAwNjI2OGNhOGM2YyIsIm5iZiI6MTcyNjYwMzg4Mi40ODkxNzIsInN1YiI6IjY2ZTlkODg0NWMwNTE5YTIzNGQzMGE0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qHGfuhfJaExeUxfqzB_QnUphv0NFJoHE_dQ6Jof_Rwo',
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(url,headers:headers);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return TopratedResponse.fromJson(json);

    } catch (e) {
      rethrow;
    }
  }


  static Future<AddMoviesListResponse> getAllMoviesList ()async{
 Uri url = Uri.https(ApiName.baseURL,EndPoints.movieslist);

 Map<String, String> headers = {
   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQ2NmVkYjViMDYzNWQ1ZDBkNzAwNjI2OGNhOGM2YyIsIm5iZiI6MTcyNjYwMzg4Mi40ODkxNzIsInN1YiI6IjY2ZTlkODg0NWMwNTE5YTIzNGQzMGE0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qHGfuhfJaExeUxfqzB_QnUphv0NFJoHE_dQ6Jof_Rwo',
   'Accept': 'application/json',
 };

 try {
   var response = await http.get(url,headers: headers);

   var bodystring = response.body ;
   var json = jsonDecode(bodystring);
   return AddMoviesListResponse.fromJson(json);
 }
 catch(e){
   throw e ;
 }
  }

  static Future<MoviesDetailsResponse> getAllMovies(int genreId) async{
    Uri url = Uri.https(ApiName.baseURL,EndPoints.moviesdetails);

    Map<String, String> headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTQ2NmVkYjViMDYzNWQ1ZDBkNzAwNjI2OGNhOGM2YyIsIm5iZiI6MTcyNjYwMzg4Mi40ODkxNzIsInN1YiI6IjY2ZTlkODg0NWMwNTE5YTIzNGQzMGE0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qHGfuhfJaExeUxfqzB_QnUphv0NFJoHE_dQ6Jof_Rwo',
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(url,headers: headers);

      var bodystring = response.body ;
      var json = jsonDecode(bodystring);
      return MoviesDetailsResponse.fromJson(json);
    }
    catch(e){
      throw e ;
    }
  }
}
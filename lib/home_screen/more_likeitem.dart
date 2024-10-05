
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/model/Response/MoreLikeThisResponse.dart';
import 'home_details/Movie_details.dart';

class MoreLikeItem extends StatelessWidget {
  static String baseUrl = "https://image.tmdb.org/t/p/original";
  final Results results;

  MoreLikeItem({required this.results});

  @override
  Widget build(BuildContext context) {
    int movieID = results.id as int ;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.blackColor,
      ),
      margin: EdgeInsets.fromLTRB(21, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(movieId:movieID ), // Pass the movie ID
                      ),
                    );
                  },
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: '$baseUrl${results.posterPath ?? ''}',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 96.87,
                      height: 127.74,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: -17,
                  child: Container(
                    width: 27,
                    height: 36,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark,
                        color: Color.fromARGB(217, 81, 79, 79),
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: -1,
                  child: Container(
                    width: 11,
                    height: 11,
                    child: Icon(Icons.add, color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Icon(
                  Icons.star,
                  color: AppColors.orangeColor,
                  size: 15,
                ),
              ),
              Text(
                results.voteAverage.toString(),
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              results.title.toString(),
              overflow: TextOverflow.ellipsis,
              // maxLines: 4, // Limit to 2 lines
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

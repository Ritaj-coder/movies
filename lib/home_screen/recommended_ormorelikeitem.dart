
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/TopRatedResponse.dart';
import 'package:movies/home_screen/recommended_details.dart';

class Recomendedormorelikeitem extends StatelessWidget {

  static String baseUrl="https://image.tmdb.org/t/p/original";

  TopRated topRated;
  Recomendedormorelikeitem({required this.topRated});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RecommendedDetails.routename,
        arguments: topRated);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: Color.fromRGBO(0, 0, 0, 0.40),
                offset: Offset(0,3)
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(0xff343534),
        ),

        margin: EdgeInsets.fromLTRB(21, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                    imageUrl: '$baseUrl${topRated.posterPath ?? ''}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width:96.87,
                    height: 127.74,
                    fit: BoxFit.cover
                ),
                Positioned(
                  top:-15,
                  left:-17,
                  child: Container(
                      width: 27,
                      height: 36,
                      child:IconButton(
                        onPressed: ()
                        {
                       /// watchlist
                        },
                        icon: Icon(
                          Icons.bookmark,
                          color: Color.fromARGB(217, 81, 79, 79),
                          size: 40,
                        ),)

                  ),
                ),
                Positioned(
                  top: 0,
                  left: -1,
                  child: Container(
                      width: 11,
                      height: 11,
                      child:  Icon(Icons.add,color: AppColors.whiteColor,)
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(Icons.star,
                    color: AppColors.orangeColor,
                    size: 15,),
                ),
                Text(topRated.voteAverage.toString(),
                    style:
                    TextStyle(
                        fontFamily:'inter',
                        fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5,0,5,0),
              child: Text(topRated.title.toString(),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style:
                  TextStyle(
                      fontFamily:'inter',
                      fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.whiteColor
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(topRated.releaseDate.toString(),
                  style:
                  TextStyle(
                      fontFamily:'inter',
                      fontSize: 8,fontWeight: FontWeight.w400,color: Color(0xffB5B4B4)
                  )),
            )

          ],
        ),
      ),
    );
  }
}
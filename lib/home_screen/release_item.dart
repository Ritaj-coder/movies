import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:movies/data/model/Response/New_ReleaseResponse.dart';
import 'package:movies/home_screen/newrelease_details.dart';

class Releaseitem extends StatelessWidget {

  static String baseUrl="https://image.tmdb.org/t/p/original";

  NewRealeases newRealease;

  Releaseitem({required this.newRealease});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, NewReleaseDetails.routename,
            arguments: newRealease);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(21, 10, 0, 0),
            clipBehavior: Clip.antiAlias,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(5)
            ),
            child:CachedNetworkImage(
                imageUrl: '$baseUrl${newRealease.posterPath ?? ''}',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width:96.87,
                height: 127.74,
                fit: BoxFit.cover
            ),
            //  Image.network(newRealease.posterPath??'',
            // width:96.87,
            // height: 127.74,
            // fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          top:-3,
          left: 4,
          child: Container(
              width: 27,
              height: 36,
              child:IconButton(
                onPressed: ()
                {
                ///watchlist

                },
                icon: Icon(
                  Icons.bookmark,
                  color: Color.fromARGB(217, 81, 79, 79),
                  size: 40,
                ),)

          ),
        ),
        Positioned(
          top: 12,
          left: 20,
          child: Container(
              width: 11,
              height: 11,
              child:  Icon(Icons.add,color: AppColors.whiteColor,)
          ),
        ),
      ],
    );
  }
}
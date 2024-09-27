
import 'package:flutter/material.dart';
import 'package:movies/browse_tab/MoviesListDetails/browse_details.dart';
import 'package:movies/data/model/Response/AddMoviesListResponse.dart';

class BrowseItem extends StatelessWidget {

  Genres movie ;
  String imagepath ;
  BrowseItem({required this.movie , required this.imagepath});
  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       Image.asset(imagepath,
       fit: BoxFit.fill,
         width: double.infinity,),

       Center(
           child:
           Text(movie.name??"",
             style: Theme.of(context).textTheme.bodyLarge,)),

       Positioned.fill(
           child: Material(
            color: Colors.transparent,
             child: InkWell(
               onTap: (){
                 Navigator.pushNamed(
                     context,
                     BrowseDetails.routename ,
                   arguments: movie.id
                 );
               },
             )

           )
       )
     ],
    );
  }
}


import 'package:flutter/material.dart';

class BrowseItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
       Image.asset("assets/images/skincare.jpg",
       fit: BoxFit.fill,
         width: double.infinity,),

       Center(
           child:
           Text("name",style: Theme.of(context).textTheme.bodyLarge,))
     ],
    );
  }
}

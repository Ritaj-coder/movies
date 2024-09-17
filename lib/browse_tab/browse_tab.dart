import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/browse_tab/browse_item.dart';

class BrowseScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Text("Browse Category",style: Theme.of(context).textTheme.bodyLarge
            !.copyWith(fontSize: 25),),

          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: GridView.builder(
                itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20
                  ),
                  itemBuilder: (context,index){
                    return BrowseItem();
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
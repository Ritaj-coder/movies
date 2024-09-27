
import 'package:flutter/material.dart';
import 'package:movies/app_colors.dart';
import 'package:readmore/readmore.dart';
import '../../data/model/Response/DetailsResponse.dart';

class DescriptionMovieDetails extends StatelessWidget {
  final List<Genres> classification;
  final String? overView;
  final num? vote;

  DescriptionMovieDetails({
    required this.classification,
    required this.overView,
    required this.vote,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Classification Wrap
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 2.0,
            children: classification.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size(65, 25),
                    padding: EdgeInsets.all(6),
                    backgroundColor: AppColors.blackColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.searchbackColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    item.name!,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 5),
          // OverView
          ReadMoreText(
            overView ?? "No overview available",
            trimLines: 3,
            colorClickableText: AppColors.orangeColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Show less',
            style: TextStyle(fontSize: 15),
            moreStyle: TextStyle(color: AppColors.orangeColor, fontWeight: FontWeight.bold),
            lessStyle: TextStyle(color: AppColors.orangeColor, fontWeight: FontWeight.bold),
          ),
          vote != 0 ? Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.orangeColor,
                size: 30,
              ),
              Text(
                '$vote',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ) : Row()
        ],
      ),
    );
  }
}

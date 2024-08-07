import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import 'ShimmerWidget.dart';

class FoodShimmer extends StatelessWidget {
  const FoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12,top: 10),
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: 6,

        itemBuilder: (context,index){
          return ShimmerWidget(shimmerWidth: width, shimmerHeight: 70.h, shimmerRadius: 12);
        }),
    );
  }
}
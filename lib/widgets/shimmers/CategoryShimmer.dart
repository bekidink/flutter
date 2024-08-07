import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import 'ShimmerWidget.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 12,top: 10),
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: 6,

        itemBuilder: (context,index){
          return ShimmerWidget(shimmerWidth: 70.w, shimmerHeight: 60.h, shimmerRadius: 12);
        }),
    );
  }
}
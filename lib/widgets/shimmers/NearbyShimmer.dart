import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import 'ShimmerWidget.dart';

class NearByShimmer extends StatelessWidget {
  const NearByShimmer({super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
      padding: const EdgeInsets.only(left: 12,top: 10),
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: 6,

        itemBuilder: (context,index){
          return ShimmerWidget(shimmerWidth: width*0.8, shimmerHeight: 180.h, shimmerRadius: 12);
        }),
    );
  }
}
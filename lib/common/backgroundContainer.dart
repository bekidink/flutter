import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/constants/constants.dart';

class BackGroundContainer extends StatelessWidget {
   const BackGroundContainer({super.key, required this.child, required this.color});
final Widget child;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r)
        ),
        // image: DecorationImage(image: AssetImage("assets/images/rest_back.jfif"),fit: BoxFit.cover,opacity: 7)
      ),
      child: child,
    );
  }
}
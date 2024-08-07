import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/LoginResponse.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});
 final LoginResponse? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*.06,
      width: width,
      color: kLightWhite,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(12.w, 0, 16, 0),child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: CircleAvatar(
                      backgroundColor: kGrayLight,
                      backgroundImage: NetworkImage(user!.profile),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Padding(padding: EdgeInsets.all(4.h),child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(style: appStyle(12, kGray, FontWeight.w600), text: user!.username),
                      ReusableText(style: appStyle(10, kGray, FontWeight.normal), text: user!.email)
                    ],
                  ),)
                ],
              ),
              Icon(Icons.edit)
            ],
          )
          ,)
        ],
      ),
    );
  }
}
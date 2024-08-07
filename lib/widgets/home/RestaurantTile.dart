import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';

import '../../views/restaurants/restaurant_page.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key,required this.restaurant});
  final RestaurantModel restaurant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Get.to(()=>RestaurantPage(restaurant:restaurant));
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 70.h,
            width: width,
            decoration: BoxDecoration(
              color: kOffWhite,
              borderRadius: BorderRadius.circular(9.r)
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: Image.network(restaurant.imageUrl,fit: BoxFit.cover,),
                        ),
                        Positioned(
                          bottom: 0,
                          
                          child:Container(
                            padding: EdgeInsets.only(left: 6.w,bottom: 2.h),
                            color: kGray.withOpacity(0.6),
                            height: 16.h,
                            width: width,
                            child: RatingBarIndicator(itemBuilder:(context,i)=>const Icon(Icons.star,color: kSecondary,),rating: 5, itemCount: 5,itemSize: 15.h,),
                          ) )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column( mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(style: appStyle(11, kDark, FontWeight.w400), text: restaurant.title),
                    ReusableText(style: appStyle(11, kGray, FontWeight.w400), text: restaurant.time),
                    SizedBox(width: width*0.6,
                    child: Text(restaurant.coords.address, overflow: TextOverflow.ellipsis,style: appStyle(9, kGray, FontWeight.w400),),
                    )
                 
                  ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: Container(
              width: 60.w,
              height: 19.h,
              decoration: BoxDecoration(
                color:restaurant.isAvailable? kPrimary:kSecondary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Center(child: ReusableText(style: appStyle(12, kLightWhite, FontWeight.w600), text:restaurant.isAvailable? "Open":"Closed")),
            ))
        ],
      ),
    );
  }
}
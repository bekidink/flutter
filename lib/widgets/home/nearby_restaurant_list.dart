import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/widgets/home/restaurant_widget.dart';
import 'package:multivendor_app/widgets/shimmers/NearbyShimmer.dart';

import '../../fetch/fetch_nearby_restaurant.dart';
import '../../model/fetch_model/Restaurant.dart';
import '../../views/restaurants/all_nearby_restaurant.dart';

class NearByRestaurantList extends HookWidget {
  const NearByRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useNearByRestaurants('12345');
    List<RestaurantModel>? restaurants=hookResults.data;
    final isLoading=hookResults.isLoading;
    return Container(
      height: 190.h,
      padding: EdgeInsets.only(left: 12.w,top:10.h),
      child:isLoading?NearByShimmer(): ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(restaurants!.length, (index) {
          var restaurant=restaurants[index];
          return RestaurantWidget(image: restaurant.imageUrl, logo: restaurant.logoUrl, title: restaurant.title, time: restaurant.time, rating: '',onTap: (){
            Get.to(()=>const AllNearbyRestaurant(),transition: Transition.cupertino,duration: Duration(milliseconds: 900));
          },);
        }),
      ),
    );
 
  }
}
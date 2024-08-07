import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/fetch/fetch_nearby_restaurant.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/widgets/home/RestaurantTile.dart';
import 'package:multivendor_app/widgets/shimmers/NearbyShimmer.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';

class AllNearbyRestaurant extends HookWidget {
  const AllNearbyRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useNearByRestaurants('12345');
    List<RestaurantModel>? restaurants=hookResults.data;
    final isLoading=hookResults.isLoading;
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kSecondary,
        title: ReusableText(style:appStyle(13, kGray, FontWeight.w600) , text: "All Fastest Foods"),
      ),
      body: BackGroundContainer(color:Colors.white, child:Padding(
        padding:  EdgeInsets.all(12.h),
        child:isLoading?NearByShimmer(): ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(restaurants!.length, (index) {
          var restaurant=restaurants[index];
          return RestaurantTile(restaurant:restaurant);
        }),
        ),
      ) )
    );
  }
}
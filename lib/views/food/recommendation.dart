import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/fetch/fetch_foods_code.dart';
import 'package:multivendor_app/widgets/home/food_tile.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../common/app_style.dart';
import '../../common/backgroundContainer.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../model/fetch_model/foodModel.dart';

class Recommendations extends HookWidget {
  const Recommendations({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useAllFoodsByCode("234598");
    List<FoodModel>? foods=hookResults.data;
    final isLoading=hookResults.isLoading;
   return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kSecondary,
        title: ReusableText(style:appStyle(13, kGray, FontWeight.w600) , text: "All Recommendations Foods"),
      ),
      body: BackGroundContainer(color:Colors.white, child:Padding(
        padding:  EdgeInsets.all(12.h),
        child:isLoading?const FoodShimmer(): ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(foods!.length, (index) {
          var food=foods[index];
          return FoodTile(food:food);
        }),
        ),
      ) )
    );
  }
}
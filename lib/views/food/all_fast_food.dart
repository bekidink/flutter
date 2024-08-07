import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/widgets/home/food_tile.dart';

import '../../common/backgroundContainer.dart';
import '../../fetch/fetch_all_foods.dart';
import '../../model/fetch_model/foodModel.dart';

class AllFastestFoods extends HookWidget {
  const AllFastestFoods({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useAllFoods();
    List<FoodModel>? foods=hookResults.data;
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
        child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(foods!.length, (index) {
          var food=foods[index];
          return FoodTile(food: food,);
        }),
        ),
      ) )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/fetch/fetch_all_foods.dart';
import 'package:multivendor_app/fetch/fetch_category_food.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:multivendor_app/widgets/home/food_tile.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

class CategoryFoodList extends HookWidget {
  const CategoryFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useCategoryFoods("234567");
    List<FoodModel>?foods=hookResults.data;
    final isLoading=hookResults.isLoading;
    return SizedBox(
      width: width,
      height: height,
      child: isLoading?FoodShimmer():Padding(padding: EdgeInsets.all(12.h),child: ListView(
        children: List.generate(foods!.length, (index) {
          var food=foods[index];
          return FoodTile(food: food,color: Colors.white,);}
        ),
      ),),
    );
  }
}
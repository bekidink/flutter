import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/fetch/fetch_all_foods.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:multivendor_app/views/food/food_page.dart';
import 'package:multivendor_app/widgets/home/food_widget.dart';
import 'package:multivendor_app/widgets/shimmers/NearbyShimmer.dart';


class FoodList extends HookWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useAllFoods();
    List<FoodModel>? foods=hookResults.data;
    final isLoading=hookResults.isLoading;
     return Container(
      height: 184.h,
      padding: EdgeInsets.only(left: 12.w,top:10.h),
      child:isLoading?const NearByShimmer(): ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(foods!.length, (index) {
          var food=foods[index];
          return FoodWidget(
            onTap: (){
              Get.to(()=>FoodPage(food: food));
            },
            image: food.imageUrl[0], logo: food.imageUrl[0], title: food.title, time: food.time, price: food.price.toStringAsFixed(2),);
        }),
      ),
    );
 
  }
}
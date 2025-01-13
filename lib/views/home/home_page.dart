import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/custom_appbar.dart';
import 'package:multivendor_app/common/custome_container.dart';
import 'package:multivendor_app/common/heading.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/category_controller.dart';
import 'package:multivendor_app/views/food/all_fast_food.dart';
import 'package:multivendor_app/views/food/recommendation.dart';
import 'package:multivendor_app/widgets/home/category_food_list.dart';
import 'package:multivendor_app/widgets/home/category_list.dart';
import 'package:multivendor_app/widgets/home/food_list.dart';
import 'package:multivendor_app/widgets/home/nearby_restaurant_list.dart';

import '../restaurants/all_nearby_restaurant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(preferredSize: Size.fromHeight(130.h), child: const CustomAppBar()),
   body: SafeArea(child: CustomContainer(widgetContent:Column(
    children: [
      const CategoryList(),
     Obx(() => controller.categoryValue==''?  Column(
        children:[
Heading(text: 'Nearby Restaurants',onTap: (){
        Get.to(()=>const AllNearbyRestaurant(),transition: Transition.cupertino,duration: const Duration(milliseconds: 900));
      },),
      const NearByRestaurantList(),
      Heading(text: 'Try Something New',onTap: (){
        Get.to(()=>const Recommendations(),transition: Transition.cupertino,duration: const Duration(milliseconds: 900));
      },),
      const FoodList(),
      Heading(text: 'Fastest food closer to you',onTap: (){
        Get.to(()=>const AllFastestFoods(),transition: Transition.cupertino,duration: const Duration(milliseconds: 900));
      },),
      const FoodList(),
      ]):CustomContainer(widgetContent: Column(
        children: [
           Heading(more: true, text: 'Explore ${controller.titleValue}',onTap: (){
        // Get.to(()=>const Recommendations(),transition: Transition.cupertino,duration: Duration(milliseconds: 900));
      },),
      const CategoryFoodList()
        ],
      ))
      )    ],
   ) )),
    );
  }
}
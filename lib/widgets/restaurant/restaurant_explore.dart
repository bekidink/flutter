import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_app/fetch/fetch_foods_code.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../constants/constants.dart';
import '../../model/fetch_model/foodModel.dart';
import '../home/food_tile.dart';

class RestaurantExplore extends HookWidget {
  const RestaurantExplore({super.key, required this.code});
  final String code;
  @override
  Widget build(BuildContext context) {
   final hookResults=useAllFoodsByCode(code);
    final foods=hookResults.data;
    final isLoading=hookResults.isLoading;
    print("print");
    return Scaffold(
      backgroundColor: kLightWhite,
      body: Container(
       
        child:isLoading?const FoodShimmer(): ListView(
          children: List.generate(foods!.length, (index) {
            final FoodModel food=foods[index];
            return FoodTile(food: food);
          }),
        ),
      ),
    );
  }
}
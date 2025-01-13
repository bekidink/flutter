import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/fetch/fetch_restaurant_by_id.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:multivendor_app/widgets/home/food_tile.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

class RestaurantMenu extends HookWidget {
  const RestaurantMenu({super.key, required this.restaurantId});
  final String restaurantId;
  @override
  Widget build(BuildContext context) {
    final hookResults=useRestaurantFoodsById(restaurantId);
    final foods=hookResults.data;
    final isLoading=hookResults.isLoading;
    return Scaffold(
      backgroundColor: kLightWhite,
      body: SizedBox(
        height: height*.7,
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
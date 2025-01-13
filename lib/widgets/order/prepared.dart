import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/fetch/fetch_orders.dart';
import 'package:multivendor_app/model/fetch_model/OrderResponses.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import 'orderd_tile.dart';

class Prepared extends HookWidget {
  const Prepared({super.key});
 
  @override
  Widget build(BuildContext context) {
    final hookResult=useFetchOrders("Placed", "Pending");
    List<OrderResponses> orders=hookResult.data;
    final isLoading=hookResult.isLoading;
    print(orders);
    if(isLoading){
      return const FoodShimmer();
    }
    return SizedBox(
      height: height*.8,
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context,i){
          var food=orders[i].orderItems[0];
        return OrderedTile(food: food,);
      }),
    );
  }
}
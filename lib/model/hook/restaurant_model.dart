import 'package:flutter/material.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
class FetchRestaurant{
  final RestaurantModel? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;
 
 FetchRestaurant({
  required this.data,
  required this.isLoading,
  required this.error,
  required this.refetch,

 });
}
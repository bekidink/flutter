import 'package:flutter/material.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
class FetchFoods{
  final List<FoodModel>? data;
  final bool isLoading;
  final Exception? error;
  final VoidCallback? refetch;
 
 FetchFoods({
  required this.data,
  required this.isLoading,
  required this.error,
  required this.refetch,

 });
}
import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/FetchModel.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/hook/restaurant_model.dart';
FetchRestaurant useFetchRestaurant(String code){
  final restaurantItems=useState<RestaurantModel?>(null);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Uri url=Uri.parse('$appBaseUrl/api/restaurant/byId/$code');
      
      final response=await http.get(url);

       print(response);
      if(response.statusCode==200){
        var restaurant=jsonDecode(response.body);
        
        restaurantItems.value=RestaurantModel.fromJson(restaurant);
      }else{
        apiError.value=apiErrorFromJson(response.body);
      }
    }catch(e){
error.value=e as Exception;
    }finally{
      isLoading.value=false;
    }

  }
  useEffect(() {
    fetchData();
    return null;
  },[]);
  void refetch(){
    isLoading.value=true;
    fetchData();
  }
  return FetchRestaurant(data: restaurantItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
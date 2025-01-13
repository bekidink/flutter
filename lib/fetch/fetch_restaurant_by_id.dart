import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/category_controller.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/FetchFoods.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
FetchFoods useRestaurantFoodsById(String id){
  final controller=Get.put(CategoryController());
  final foodsItems=useState<List<FoodModel>?>(null);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  print('${controller.categoryValue} value');
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Uri url=Uri.parse('$appBaseUrl/api/foods/restaurant/foods/$id');
      final response=await http.get(url);
       print('${response.body} value');

      if(response.statusCode==200){
        
        
       foodsItems.value=foodModelFromJson(response.body);
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
    Future.delayed(const Duration(seconds: 2));
    fetchData();
    return null;
  },[controller.categoryValue]);
  void refetch(){
    isLoading.value=true;
    fetchData();
  }
  return FetchFoods(data: foodsItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
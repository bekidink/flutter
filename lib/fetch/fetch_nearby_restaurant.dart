import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/FetchModel.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';
import 'package:http/http.dart' as http;
FetchHook useNearByRestaurants(String code){
  final restaurantsItems=useState<List<RestaurantModel>?>(null);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Uri url=Uri.parse('$appBaseUrl/api/restaurant/$code');
      
      final response=await http.get(url);
      if(response.statusCode==200){
        
        
        restaurantsItems.value=restaurantModelFromJson(response.body);
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
  return FetchHook(data: restaurantsItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
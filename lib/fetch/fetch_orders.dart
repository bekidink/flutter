import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/FetchModel.dart';
import 'package:multivendor_app/model/fetch_model/OrderResponses.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';
import 'package:http/http.dart' as http;
FetchHook useFetchOrders(String orderStatus,String paymentStatus){
  final restaurantsItems=useState<List<OrderResponses>>([]);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  final box=GetStorage();
  String?token=box.read("token");
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Uri url=Uri.parse('$appBaseUrl/api/order?paymentStatus=$paymentStatus');
      Map<String,String>headers={
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      };
      final response=await http.get(url,headers: headers);
      
      if(response.statusCode==200){
        
        print(response.body);
        restaurantsItems.value=orderResponsesFromJson(response.body);
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
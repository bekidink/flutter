import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';

import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/hook/default.dart';

import '../controllers/address_controller.dart';
FetchDefault useFetchDefault(){
  final controller=Get.put(AddressController());
  final box=GetStorage();
  String?token=box.read("token");
  final restaurantsItems=useState<AddressResponse?>(null);
  final isLoading=useState<bool>(false);
  final error=useState<Exception?>(null);
  final apiError=useState<ApiError?>(null);
  Future<void> fetchData()async{
    isLoading.value=true;
    try{
      Map<String,String>headers={
        'Content-Type':'application/json',
        'Authorization':'Bearer $token'
      };
      Uri url=Uri.parse('$appBaseUrl/api/address/default');
      
      final response=await http.get(url,headers: headers);
      if(response.statusCode==200){
        var data=response.body;
        var decoded=jsonDecode(data);
        box.write('defaultAddress', true);
        restaurantsItems.value=AddressResponse.fromJson(decoded);
  controller.setAddress=restaurantsItems.value!.addressLine1;
  
      }else{
        box.write('defaultAddress', false);
        apiError.value=apiErrorFromJson(response.body);
      }
    }catch(e){

// error.value=e as Exception;
box.write('defaultAddress', false);
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
  return FetchDefault(data: restaurantsItems.value, isLoading: isLoading.value, error: error.value, refetch: refetch);
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../model/fetch_model/ApiError.dart';
class AddressController extends GetxController{
  final box=GetStorage();
  RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool value){
    _isLoading.value=value;
  }
  RxString _addressLine=''.obs;
  String get addressLine=>_addressLine.value;
  set setAddress(String value){
    _addressLine.value=value;
  }
  void addAddress(String address)async{
    setLoading=true;
    String token=box.read("token");
    var url=Uri.parse(
      "$appBaseUrl/api/address"
    );
    Map<String,String>headers={"Content-Type":'application/json',
    'Authorization':'Brearer $token'
    };
    try{
var response=await http.post(url,headers: headers,body: address);
print(response.statusCode);
if(response.statusCode==200){
      setLoading=false;
      Get.snackbar("Address Added Successfully", "Enjoy your awesome experience",colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(
        Icons.check_circle_outline,
        color: kLightWhite,
      ));
}else{
  var error=apiErrorFromJson(response.body);
  Get.snackbar("Added to cart", error.message,colorText: kLightWhite,backgroundColor: kRed,icon:const Icon(
        Icons.check_circle_outline,
        color: kLightWhite,
      ));
}
    }catch(e){

    }finally{
      setLoading=false;
    }
  }


}
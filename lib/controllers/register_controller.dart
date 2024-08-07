import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:http/http.dart'as http;
import 'package:multivendor_app/model/fetch_model/ApiError.dart';

import '../model/fetch_model/SuccessModel.dart';

class RegisterController extends GetxController{
  final box=GetStorage();
  RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool newState){
    _isLoading.value=newState;
  }
  void registerFunction(String data)async{
    setLoading=true;
    Uri url=Uri.parse('$appBaseUrl/api/auth/register');
    Map<String,String>headers={"Content-Type":'application/json'};
    try{
var response=await http.post(url,headers: headers,body: data);
if(response.statusCode==200){
    var data=successModelFromJson(response.body);

    setLoading=false;
    Get.snackbar("You are succefully register ",data.message ,colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(Ionicons.fast_food_outline));

}

else{
  var error=apiErrorFromJson(response.body);
  Get.snackbar("Failed to login", error.message,colorText: kLightWhite,backgroundColor: kRed,icon:const Icon(Icons.error_outline));
}
    }catch(e){

    }
  }
 
}
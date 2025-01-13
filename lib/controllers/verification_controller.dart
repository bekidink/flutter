import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../model/fetch_model/ApiError.dart';
import '../model/fetch_model/LoginResponse.dart';
import 'package:http/http.dart'as http;

import '../views/entrypoint.dart';
class VerificationController extends GetxController{
  
  String _code="";
  String get code=>_code;
  set setCode(String value){
    _code=value;
  }
  final box=GetStorage();
  final RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool newState){
    _isLoading.value=newState;
  }
   void verificationFunction()async{
    setLoading=true;
    String? accessToken=box.read('token');
    Uri url=Uri.parse('$appBaseUrl/api/users/verify/$code');
    Map<String,String>headers={"Content-Type":'application/json','Authorization':'Bearer $accessToken'};
    try{
var response=await http.get(url,headers: headers);
print(response.statusCode);
if(response.statusCode==200){
 
  LoginResponse data=loginResponseFromJson(response.body);
  String userId=data.id;
  String userData=jsonEncode(data);
   print(data);
  box.write(userId, userData);
  box.write("token", data.userToken);
   box.write("userId", data.id);
    box.write("verification", data.verification);
    setLoading=false;
    Get.snackbar("You are succefully logged in", "Enjoy your awesome experience",colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(Ionicons.fast_food_outline));

Get.offAll(()=>MainScreen(),transition: Transition.fade,duration:const Duration(
  milliseconds: 900
));
}else{
  var error=apiErrorFromJson(response.body);
  Get.snackbar("Failed to login", error.message,colorText: kLightWhite,backgroundColor: kRed,icon:const Icon(Icons.error_outline));
}
    }catch(e){

    }
  }
  
  
  
}
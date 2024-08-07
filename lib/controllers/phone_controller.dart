import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../model/fetch_model/ApiError.dart';
import '../model/fetch_model/LoginResponse.dart';
import '../views/entrypoint.dart';
import 'package:http/http.dart'as http;
class PhoneController extends GetxController{
  String _phone="";
  String get phone=>_phone;
  set setPhone(String value){
    _phone=value;
    print(value);
  }
  final box=GetStorage();
  RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool newState){
    _isLoading.value=newState;
  }
   void verifyPhone()async{
    setLoading=true;
    String? accessToken=box.read('token');
    Uri url=Uri.parse('$appBaseUrl/api/users/verify_phone/$phone');
    Map<String,String>headers={"Content-Type":'application/json','Authorization':'Bearer ${accessToken}'};
    try{
var response=await http.get(url,headers: headers);

if(response.statusCode == 200){
  
 Get.snackbar("You are succefully verified", "Enjoy your awesome experience",colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(Ionicons.fast_food_outline));
  // LoginResponse data=loginResponseFromJson(response.body);
 final data=jsonDecode(response.body);
print(data._id);
  // String userId=response.body;
  // String userData=jsonEncode(data);
   
  // box.write(userId, userData);
  // box.write("token", data.userToken);
  //  box.write("userId", data.id);
  //   box.write("verification", data.verification);
    setLoading=false;
    
// if(data.verification==false){
//   Get.offAll(()=>const VerificationPage(),transition: Transition.fade,duration:const Duration(
//     milliseconds: 90
//   ));
// }
// Get.offAll(()=>MainScreen(),transition: Transition.fade,duration:const Duration(
//   milliseconds: 900
// ));
}else{
  var error=apiErrorFromJson(response.body);
  Get.snackbar("Failed to login", error.message,colorText: kLightWhite,backgroundColor: kRed,icon:const Icon(Icons.error_outline));
}
    }catch(e){

    }
  }
  
  
  
}
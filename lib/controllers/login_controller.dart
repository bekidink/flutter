import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:http/http.dart'as http;
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/LoginResponse.dart';
import 'package:multivendor_app/views/auth/login_page.dart';
import 'package:multivendor_app/views/entrypoint.dart';
class LoginController extends GetxController{
  final box=GetStorage();
  final RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool newState){
    _isLoading.value=newState;
  }
  void loginFunction(String data)async{
    setLoading=true;
    Uri url=Uri.parse('$appBaseUrl/api/auth/login');
    Map<String,String>headers={"Content-Type":'application/json'};
    try{
var response=await http.post(url,headers: headers,body: data);
setLoading=false;
print(response.statusCode);
if(response.statusCode==200){
 
  LoginResponse data=loginResponseFromJson(response.body);
  String userId=data.id;
  String userData=jsonEncode(data);
   print(data.verification);
  box.write(userId, userData);
  box.write("token", data.userToken);
   box.write("userId", data.id);
    box.write("verification", data.verification);
    setLoading=false;
    Get.snackbar("You are succefully logged in", "Enjoy your awesome experience",colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(Ionicons.fast_food_outline));
// if(data.verification==false){
//   Get.offAll(()=>const VerificationPage(),transition: Transition.fade,duration:const Duration(
//     milliseconds: 90
//   ));
// }
if(data.verification==false){
Get.offAll(()=>MainScreen(),transition: Transition.fade,duration:const Duration(
  milliseconds: 900
));
}

}else{
  var error=apiErrorFromJson(response.body);
  Get.snackbar("Failed to login", error.message,colorText: kLightWhite,backgroundColor: kRed,icon:const Icon(Icons.error_outline));
}
    }catch(e){
setLoading=false;
    }
  }
  
  
  
  void logout(){
    box.erase();
    Get.offAll(()=>const LoginPage(),transition: Transition.fade,duration: const Duration(milliseconds: 90));
  }
  LoginResponse? getUserInfo(){
    String? userId=box.read("userId");
    String? userData;
    if(userId!=null){
       userData=box.read(userId.toString());
    }
    if(userData !=null){
      return loginResponseFromJson(userData);
    }
    return null;
  }
}
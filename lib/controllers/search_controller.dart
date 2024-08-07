import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/ApiError.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:http/http.dart' as http;
class SearchFormController extends GetxController{
  RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  RxBool _isTriggerws=false.obs;
  bool get isTriggersws=>_isTriggerws.value;
  set setLoading(bool value){
    _isLoading.value=value;
  }
  set setTriggersws(bool value){
    _isTriggerws.value=value;
  }
  List<FoodModel>? searchResults;
  void searchFoods(String key)async{
    setLoading=true;
    Uri url=Uri.parse("$appBaseUrl/api/foods/search/$key");
    try{
var response=await http.get(url);
if(response.statusCode==200){
  searchResults=foodModelFromJson(response.body);
  setLoading=false;
}else{
  setLoading=false;
  var error=apiErrorFromJson(response.body);
}
    }catch(e){
setLoading=false;
debugPrint(e.toString());
    }
  }


}
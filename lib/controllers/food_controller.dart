import 'dart:ffi';

import 'package:get/get.dart';
import 'package:multivendor_app/model/additive_obs.dart';

import '../model/fetch_model/foodModel.dart';

class FoodController extends GetxController{
  RxInt currentPage=0.obs;
  bool initialCheckValue=false;
  var additivesList=<AdditiveObs>[].obs;
  void changePage(int index){
    currentPage.value=index;
  }
  RxInt count=1.obs;

  void increament(){
    count.value++;
  }
  void decreament(){
    if(count.value>1){
      count.value--;
    }
  }
  void loadAdditivesList(List<Additive> additives){
    additivesList.clear();
    for(var additiveInfo in additives){
      var additive=AdditiveObs(id: additiveInfo.id, title: additiveInfo.title, price: additiveInfo.price,checked: initialCheckValue);
    if(additives.length== additivesList.length){

    }else{
      additivesList.add(additive);
    }
    }
   
  }
List<String>getList(){
  List<String>ads=[];
  for(var additive in additivesList){
    if(additive.isChecked.value && !ads.contains(additive.title)){
      ads.add(additive.title);
    }else if(!additive.isChecked.value && ads.contains(additive.title)){
      ads.remove(additive.title);
    }
  }
  return ads;
}
List<String> getCartAdditive(){
  List<String>additives=[];
  for(var additive in additivesList){
    if(additive.isChecked.value && !additives.contains(additive.title)){
      additives.add(additive.title);
    }else if(!additive.isChecked.value && additives.contains(additive.title)){
additives.remove(additive.title);
    }
  }
  return additives;
}

RxDouble _totalPrice=0.0.obs;
double get additivePrice=>_totalPrice.value;
set setTotalPrice(double newPrice){
_totalPrice.value=newPrice;
}
double getTotalPrice(){
  double totalPrice=0.0;
  for(var additive in additivesList){
    if(additive.isChecked.value){
      totalPrice+=double.tryParse(additive.price)?? 0.0;
    }
  }
setTotalPrice=totalPrice;
return totalPrice;
}
}
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:http/http.dart' as http;
class UserLocationController extends GetxController{
  RxBool _isDefault=false.obs;
  bool get isDefault=>_isDefault.value;
  set setIsDefault(bool value){
    _isDefault.value=value;
  }
  RxInt _tabIndex=0.obs;
  int get tabIndex => _tabIndex.value;
  set setTabIndex(int value){
    _tabIndex.value=value;
  }
  
  LatLng position=LatLng(0, 0);
  
  void setPostion(LatLng value){
  position=value;
  }
  RxString _address=''.obs;
  String get address=> _address.value;
  set setAddress(String value){
    _address.value=value;
  }
RxString _postalcode=''.obs;
String get postalCode=>_postalcode.value;
set SetPostalCode(String value){
  _postalcode.value=value;
}
  void getUserAddress(LatLng position)async{
final url =Uri.parse(
  'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey'
);
final response=await http.get(url);

if(response.statusCode == 200){
  final responseBody=jsonDecode(response.body);
  print(response.body);
  final address=responseBody['results'][0]['formatted_address'];
  setAddress=address;
  final addressComponents=responseBody['results'][0]['address_components'];
  for(var component in addressComponents){
    if(component['types'].contains('postal_code')){
SetPostalCode=component['long_name'];
    }
  }
}
  }
}
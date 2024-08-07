import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:multivendor_app/model/fetch_model/OrderResponse.dart';
import 'package:multivendor_app/model/fetch_model/payment.dart';
import 'package:multivendor_app/widgets/order/payment_webview.dart';

import '../constants/constants.dart';
import '../model/fetch_model/OrderRequest.dart';
class OrderController extends GetxController{
  RxBool _isLoading=false.obs;
  bool get isLoading=>_isLoading.value;
  set setLoading(bool value){
    _isLoading.value=value;
  }
  RxString _paymentUrl=''.obs;
  String get paymentUrl=>_paymentUrl.value;
  set setPaymentUrl(String url){
    _paymentUrl.value=url;
  }
  void createOrder(String data,OrderRequest item)async{
    final box=GetStorage();
    String accessToken=box.read("token");
    String userId=box.read("userId");
    Uri url=Uri.parse('$appBaseUrl/api/order');
    Map<String,String>headers={
      'Content-Type':'application/json',
      "Authorization":"Bearer $accessToken"
    };
    try{
      var response=await http.post(url,headers: headers,body: data);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        OrderResponse data=orderResponseFromJson(response.body);
        String orderId=data.orderId;
        Payment payment=Payment(userId:userId , cartItems: [
          CartItem(name: item.orderItems.foodId, id:  orderId, price: item.orderItems.price, quantity: item.orderItems.quantity, restaurantId: item.restaurantId)
        ]);
        print(payment);
        String paymentData=paymentToJson(payment);
        paymentFunction(paymentData);
         Get.snackbar("Added to cart", "Enjoy your awesome experience",colorText: kLightWhite,backgroundColor: kPrimary,icon:const Icon(
        Icons.check_circle_outline,
        color: kLightWhite,
      ));
      }
    }catch(e){

    }
  }
  void paymentFunction(String payment)async{
    setLoading=true;
    Uri url=Uri.parse('$appBaseUrl2/api/stripe/create-checkout-session');
    try{
      var response=await http.post(url,headers:{'Content-Type':'application/json',},body: payment);
      print(response.body);
      if(response.statusCode==200){
var urlData=jsonDecode(response.body);
setPaymentUrl=urlData['url'];
          setLoading=false;
          Get.to(()=>PaymentWebView());
      }
    }catch(e){

    }
  }
}
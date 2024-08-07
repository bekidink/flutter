import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/controllers/order_controller.dart';
import 'package:multivendor_app/views/entrypoint.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController=Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading:GestureDetector(
          onTap: (){
            orderController.setPaymentUrl='';
            Get.off(()=>MainScreen());
          },
          child:const Icon(
            AntDesign.closecircleo,
            color: Colors.black,
          ),
        ) ,
      ),
      body: Center(
child: Column(
  children: [
    Image.asset("assets/images/bg1.png",color: Colors.red,),
    ReusableText(style: appStyle(20, Colors.black, FontWeight.bold), text: 'Payment Failed')
  ],
),
      ),
    );
  }
}
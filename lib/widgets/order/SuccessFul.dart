import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/order_controller.dart';
import 'package:multivendor_app/views/entrypoint.dart';

class SuccessFul extends StatelessWidget {
  const SuccessFul({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController=Get.put(OrderController());
    Timer(const Duration(seconds: 2),(){
orderController.setLoading=true;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
          child: GestureDetector(
            onTap: (){
              Get.offAll(()=>MainScreen());
            },
            child: Icon(AntDesign.closecircle,color: kGrayLight,),
          ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg1.png',),fit: BoxFit.cover)
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height *.3.h,
              width: width-40,
              decoration: BoxDecoration(
                color: kOffWhite,
                borderRadius: BorderRadius.all(Radius.circular(20.r))
              ),
              child: Padding(padding: EdgeInsets.all(8),child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableText(style: appStyle(13,kGray , FontWeight.normal), text: "Payment Successful"),
                  Divider(thickness: 2,),
                  Padding(padding: EdgeInsets.all(8),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Order Id'),
                           ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Order Id')
                        ]
                      ),
                       TableRow(
                        children: [
                          ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Payment ID'),
                           ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: '12222')
                        ]
                      ),
                        TableRow(
                        children: [
                          ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Payment Method'),
                           ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Stripe')
                        ]
                      ),
                       TableRow(
                        children: [
                          ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Amount'),
                           ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Stripe'),
                           
                        ]
                      ),
                       TableRow(
                        children: [
                          ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Restaurant'),
                           ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: 'Stripe'),
                           
                        ]
                      )
                    ],
                  ),
                  )
                ],
              ),),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/widgets/profile/shipping_page.dart';

import '../constants/constants.dart';
import 'app_style.dart';
import 'custom_button.dart';
import 'reusable_text.dart';

Future<dynamic>showAddressSheet(BuildContext context){
    return showModalBottomSheet(context: context, builder: (BuildContext context ){
      return Container(
        height: 500.h,
        width: width,
        decoration: BoxDecoration(
          
          image: const DecorationImage(image: AssetImage('assets/images/bg4.jpg'),fit: BoxFit.fill,),color: kLightWhite,borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r)
          )
        ),
        child: Padding(padding:EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ReusableText(style: appStyle(18, kPrimary, FontWeight.w600), text: "Add Address"),
            SizedBox(
              height: 250.h,
              child: Column(
                children: List.generate(verficationReasons.length, (index) {
                return ListTile(
                  leading:const Icon(Icons.check_circle_outline,color: kPrimary,),
                  title: Text(
                    textAlign: TextAlign.justify,
                    verficationReasons[index],style: appStyle(11, kGray, FontWeight.normal),
                  ),
                ) ; 
                }),
              )
            ),
            SizedBox(height: 5.h,),
            CustomButton(text: "Go To add address",onTap: (){
              Get.to(()=>const ShippingPage());
            },btnHeight: 35.h,)
          ],
        ),
         ),
      );
    });
  }

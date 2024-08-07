import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/custome_container.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/verification_controller.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(VerificationController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        title: ReusableText(style: appStyle(12, kGray, FontWeight.w600),text: "Please Verify Your Account",),
        centerTitle: true,
        backgroundColor: kOffWhite,
        elevation: 0,
      ),
      body: CustomContainer(
        color: Colors.white,
        widgetContent: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: SizedBox(
          height: height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
             Lottie.asset('assets/anime/delivery.json'),
             SizedBox(
              height: 30.h,
             ),
             Center(child: ReusableText(style: appStyle(20, kPrimary, FontWeight.w600), text: 'Verify Your Account')),
             SizedBox(
              height: 10.h,
             ),
             ReusableText(style: appStyle(10, kGray, FontWeight.normal), text: "Enter the 6-digit code sent to your email"),
             SizedBox(
              height: 20.h,
             ),
             OtpTextField(
        numberOfFields: 6,
        borderColor: kPrimary,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        borderWidth: 2,
        textStyle: appStyle(17, kDark, FontWeight.w600),
        onCodeChanged: (String code) {
            //handle validation or checks here           
        },
        //runs when every textfield is filled
        onSubmit: (String verificationCode){
            controller.setCode=verificationCode;
        }, // end onSubmit
    ),
             CustomButton(
              text: 'V E R I F Y',
              btnHeight: 35.h,
              btnWidth: width,
              onTap: (){
                controller.verificationFunction();
              },
             )
            ],
          ),
                ),
        ),),
    );
  }
}
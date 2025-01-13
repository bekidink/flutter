import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_app/views/auth/login_page.dart';

import '../../common/app_style.dart';
import '../../common/backgroundContainer.dart';
import '../../common/custom_button.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../controllers/login_controller.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        title: Center(
          child: ReusableText(style: appStyle(20,kLightWhite,  FontWeight.bold),text: 'Foodly Family',),
        ),
      ),
      body: BackGroundContainer(color: kOffWhite, child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r)
        ),
        child: ListView(
          children: [
            Lottie.asset('assets/anime/delivery.json')
          ,
          
             
             
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                text: 'L O G I N',
                onTap: () {
                Get.to(()=>const LoginPage());
                },
                btnHeight: 40.h,
                btnWidth: width,
              ),
              
            ],
          ),
          )
          
        ),
      );
    
  }
}
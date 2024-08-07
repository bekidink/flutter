import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/password_controller.dart';

import '../constants/constants.dart';
import 'app_style.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key, this.onEditingComplete, this.keyboardType, this.initialValue, this.controller,});
final void Function()? onEditingComplete;
 final TextInputType? keyboardType;
 final String? initialValue;
 final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final passwordController=Get.put(PasswordController());

    return Obx(() =>   TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: TextInputType.visiblePassword,
      initialValue: initialValue,
      obscureText: passwordController.password,
      controller: controller,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter valid password";
        }else{
          return null;
        }
      },
      style: appStyle(12, kGray, FontWeight.normal),
      decoration: InputDecoration(
        hintText: 'password',
        prefixIcon:const Icon(CupertinoIcons.lock_circle),
        suffixIcon: GestureDetector(
          onTap: (){
            passwordController.setPassword=!passwordController.password;
          },
          child: Icon(
           passwordController.password? Icons.visibility:Icons.visibility_off,
            size: 25,
            color: kGrayLight,
          ),
        ) ,
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        errorBorder:OutlineInputBorder(
borderRadius: BorderRadius.all(Radius.circular(12.r)),
borderSide:const BorderSide(
  color: kRed,width: .5
)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide:const BorderSide(color: kPrimary,width: .5)
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide:const BorderSide(color: kRed,width: .5)
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: kGray,width: .5),
          borderRadius: BorderRadius.all(Radius.circular(9.r))
        ) ,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9.r)),
          borderSide:const BorderSide(color: kPrimary,width: .5)
        )
      ),
    )
  
);
  
  }
}
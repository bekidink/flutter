import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/constants/constants.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, this.onEditingComplete, this.keyboardType, this.initialValue, this.controller, this.hintText, this.prefixIcon});
 final void Function()? onEditingComplete;
 final TextInputType? keyboardType;
 final String? initialValue;
 final TextEditingController? controller;
 final String? hintText;
 final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType?? TextInputType.emailAddress,
      initialValue: initialValue,
      controller: controller,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter valid data";
        }else{
          return null;
        }
      },
      style: appStyle(12, kGray, FontWeight.normal),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
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
    );
  }
}
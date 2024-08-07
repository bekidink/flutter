import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/constants/constants.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({super.key, this.keyboardType, this.controller, this.onEditingComplete, this.obscureText, this.suffixIcon, this.validator, this.prefixIcon, this.hintText, required this.maxLines});
 final TextInputType? keyboardType;
 final TextEditingController? controller;
 final void Function()? onEditingComplete;
 final bool? obscureText;
 final Widget? suffixIcon;
 final Widget? prefixIcon;
 final String? Function(String?)? validator;
 final String? hintText;
 final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.h),
      padding: EdgeInsets.only(left: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: kGray,width: 0.4),
        borderRadius: BorderRadius.circular(9.r)
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText?? false,
        maxLines: maxLines?? 1,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: appStyle(11, kDark, FontWeight.normal),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText
        ),

      ),
    );
  }
}
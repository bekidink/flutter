import 'package:flutter/material.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';

class RowText extends StatelessWidget {
  const RowText({super.key, required this.first, required this.second});
final String first;
final String second;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(style: appStyle(10, kGray, FontWeight.w500), text: first),
        ReusableText(style: appStyle(10, kGray, FontWeight.w500), text: second)
      ],
    );
  }
}
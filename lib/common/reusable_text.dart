import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
   ReusableText({super.key,required this.style,required this.text});
final String text;
final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      style: style,
    );
  }
}